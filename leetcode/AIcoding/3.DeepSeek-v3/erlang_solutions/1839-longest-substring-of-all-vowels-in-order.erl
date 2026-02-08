-spec beautifulSubstrings(S :: unicode:unicode_binary()) -> integer().
beautifulSubstrings(S) ->
    Vowels = sets:from_list("aeiou"),
    lists:foldl(fun(_, {Count, Start, CurrentSet}) ->
        case sets:is_element(S, Vowels) of
            true ->
                NewSet = sets:add_element(S, CurrentSet),
                case sets:size(NewSet) =:= 5 of
                    true -> {Count + 1, Start + 1, sets:del_element(lists:nth(Start, S), NewSet)};
                    false -> {Count, Start, NewSet}
                end;
            false -> {Count, Start + 1, sets:new()}
        end
    end, {0, 1, sets:new()}, S),
    Count.