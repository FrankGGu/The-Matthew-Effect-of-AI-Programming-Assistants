-spec are_occurrences_equal(S :: unicode:unicode_binary()) -> boolean().
are_occurrences_equal(S) ->
    Counts = lists:foldl(fun(Char, Acc) ->
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, unicode:characters_to_list(S)),
    Values = maps:values(Counts),
    case Values of
        [] -> true;
        [V | Vs] -> lists:all(fun(X) -> X =:= V end, Vs)
    end.