-spec max_number_of_balloons(Text :: unicode:unicode_binary()) -> integer().
max_number_of_balloons(Text) ->
    Counts = lists:foldl(fun(Char, Acc) ->
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, unicode:characters_to_list(Text)),
    B = maps:get($b, Counts, 0),
    A = maps:get($a, Counts, 0),
    L = maps:get($l, Counts, 0) div 2,
    O = maps:get($o, Counts, 0) div 2,
    N = maps:get($n, Counts, 0),
    lists:min([B, A, L, O, N]).