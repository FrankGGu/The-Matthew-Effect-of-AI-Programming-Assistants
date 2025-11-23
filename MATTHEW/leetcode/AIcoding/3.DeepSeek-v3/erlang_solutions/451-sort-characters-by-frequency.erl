-spec frequency_sort(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
frequency_sort(S) ->
    Counts = lists:foldl(fun(Char, Acc) ->
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, unicode:characters_to_list(S)),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A >= B end, maps:to_list(Counts)),
    Result = lists:foldl(fun({Char, Count}, Acc) ->
                            [lists:duplicate(Count, Char) | Acc]
                         end, [], Sorted),
    unicode:characters_to_binary(lists:flatten(Result)).