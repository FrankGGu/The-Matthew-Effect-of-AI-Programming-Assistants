-spec character_replacement(S :: unicode:unicode_binary(), K :: integer()) -> integer().
character_replacement(S, K) ->
    List = binary_to_list(S),
    character_replacement(List, K, 0, 0, #{}, 0).

character_replacement(List, K, Left, Right, CountMap, MaxLen) ->
    case Right < length(List) of
        true ->
            Char = lists:nth(Right + 1, List),
            NewCountMap = maps:update_with(Char, fun(V) -> V + 1 end, 1, CountMap),
            MaxCount = max_count(NewCountMap),
            WindowLen = Right - Left + 1,
            case WindowLen - MaxCount =< K of
                true ->
                    NewMaxLen = max(MaxLen, WindowLen),
                    character_replacement(List, K, Left, Right + 1, NewCountMap, NewMaxLen);
                false ->
                    LeftChar = lists:nth(Left + 1, List),
                    UpdatedCountMap = maps:update_with(LeftChar, fun(V) -> V - 1 end, NewCountMap),
                    character_replacement(List, K, Left + 1, Right, UpdatedCountMap, MaxLen)
            end;
        false ->
            MaxLen
    end.

max_count(CountMap) ->
    lists:max(maps:values(CountMap)).