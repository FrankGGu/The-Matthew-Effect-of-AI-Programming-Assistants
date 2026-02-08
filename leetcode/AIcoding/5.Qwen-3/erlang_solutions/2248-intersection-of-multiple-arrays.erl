-module(intersection_of_multiple_arrays).
-export([intersection/1]).

intersection(Lists) ->
    Sets = [lists:usort(L) || L <- Lists],
    lists:foldl(fun(S, Acc) -> sets:intersection(S, Acc) end, hd(Sets), tl(Sets)),
    lists:sort(sets:to_list(hd(Sets))).