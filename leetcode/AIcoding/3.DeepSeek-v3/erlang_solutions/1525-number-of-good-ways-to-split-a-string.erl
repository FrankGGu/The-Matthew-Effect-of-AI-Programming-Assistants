-spec num_splits(S :: unicode:unicode_binary()) -> integer().
num_splits(S) ->
    Left = maps:new(),
    Right = count_chars(S, maps:new()),
    {Count, _} = lists:foldl(fun(Char, {Acc, L}) ->
        L1 = maps:update_with(Char, fun(V) -> V + 1 end, 1, L),
        R1 = maps:update_with(Char, fun(V) -> V - 1 end, 0, Right),
        R2 = case maps:get(Char, R1) of
            0 -> maps:remove(Char, R1);
            _ -> R1
        end,
        case maps:size(L1) =:= maps:size(R2) of
            true -> {Acc + 1, L1};
            false -> {Acc, L1}
        end
    end, {0, Left}, S),
    Count.

count_chars([], Map) -> Map;
count_chars([Char | Rest], Map) ->
    count_chars(Rest, maps:update_with(Char, fun(V) -> V + 1 end, 1, Map)).