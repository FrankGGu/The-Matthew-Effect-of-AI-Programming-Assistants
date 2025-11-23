-module(solution).
-export([count_fair_pairs/3]).

count_fair_pairs(A, L, R) ->
    Sorted = lists:sort(A),
    count_pairs(Sorted, L, R).

count_pairs([], _, _) -> 0;
count_pairs(Sorted, L, R) ->
    CountL = count_less_equal(Sorted, L),
    CountR = count_less_equal(Sorted, R),
    CountR - CountL.

count_less_equal([], _) -> 0;
count_less_equal(Sorted, X) ->
    case lists:binary_search(fun(Y) -> Y =< X end, Sorted) of
        {ok, Index} -> Index + 1;
        _ -> 0
    end.