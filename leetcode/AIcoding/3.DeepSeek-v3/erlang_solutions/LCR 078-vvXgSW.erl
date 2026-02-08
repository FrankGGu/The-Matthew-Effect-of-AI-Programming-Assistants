mergeKLists(Lists) ->
    case lists:filter(fun(L) -> L =/= [] end, Lists) of
        [] -> [];
        NonEmptyLists ->
            {Heads, Tails} = lists:foldl(fun([H|T], {Hs, Ts}) -> {[H|Hs], [T|Ts]} end, {[], []}, NonEmptyLists),
            SortedHeads = lists:sort(fun({Val1, _}, {Val2, _}) -> Val1 =< Val2 end, lists:zip(Heads, lists:seq(1, length(Heads)))),
            {MinVal, MinIdx} = hd(SortedHeads),
            [MinVal | mergeKLists(lists:keyreplace(MinIdx, 2, lists:zip(lists:seq(1, length(Tails)), Tails), {MinIdx, lists:nth(MinIdx, Tails)}))]
    end.