-spec min_operations(S :: unicode:unicode_binary()) -> integer().
min_operations(S) ->
    FreqMap = lists:foldl(fun(Char, Acc) ->
                                  maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                          end, #{}, unicode:characters_to_list(S)),
    Freqs = lists:sort(maps:values(FreqMap)),
    min_operations(Freqs, 0).

min_operations([_], Acc) -> Acc;
min_operations([H | T], Acc) ->
    case H =:= hd(T) of
        true -> min_operations(T, Acc);
        false -> min_operations([H - 1 | T], Acc + 1)
    end.