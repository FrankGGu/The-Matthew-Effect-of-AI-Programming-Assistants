-module(solution).
-export([min_absolute_sum_difference/2]).

min_absolute_sum_difference(A, B) ->
    N = length(A),
    A_sorted = lists:sort(A),
    Diff = lists:map(fun(X, Y) -> abs(X - Y) end, A, B),
    Original_sum = lists:sum(Diff),
    Max_increase = lists:foldl(fun(X, Acc) ->
        Index = binary_search(A_sorted, X),
        New_diff = if Index > 0 -> abs(lists:nth(Index, A_sorted) - X);
                     true -> infinity
                   end,
        New_diff2 = if Index < N -> abs(lists:nth(Index + 1, A_sorted) - X);
                     true -> infinity
                   end,
        Max_new_diff = max(New_diff, New_diff2),
        Max_increase = Max_new_diff - abs(X - lists:nth(Index, A)),
        max(Acc, Max_increase)
    end, 0, B),
    (Original_sum - Max_increase) rem 1000000007.

binary_search(List, X) ->
    binary_search(List, X, 1, length(List)).

binary_search(_, _, Low, High) when Low > High -> 0;
binary_search(List, X, Low, High) ->
    Mid = div(Low + High, 2),
    case lists:nth(Mid, List) of
        Y when Y == X -> Mid;
        Y when Y < X -> binary_search(List, X, Mid + 1, High);
        _ -> binary_search(List, X, Low, Mid - 1)
    end.