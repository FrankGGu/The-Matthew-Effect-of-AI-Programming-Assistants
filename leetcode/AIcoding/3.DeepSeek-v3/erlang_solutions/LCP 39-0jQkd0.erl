-spec minimum_moves(Source :: [[integer()]], Target :: [[integer()]]) -> integer().
minimum_moves(Source, Target) ->
    Count = lists:foldl(fun({S, T}, Acc) ->
        Acc + abs(S - T)
    end, 0, lists:zip(lists:flatten(Source), lists:flatten(Target))),
    Count div 2.