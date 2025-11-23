-module(solution).
-export([min_operations/1]).

min_operations(A) ->
    TotalSum = lists:sum(A),
    HalfSum = TotalSum / 2,
    Sorted = lists:sort(fun(A, B) -> A > B end, A),
    min_operations_helper(Sorted, HalfSum, 0, 0).

min_operations_helper([], _, _, Count) -> Count;
min_operations_helper([H | T], HalfSum, CurrentSum, Count) ->
    NewSum = CurrentSum + H / 2,
    if
        NewSum >= HalfSum -> Count + 1;
        true -> min_operations_helper(T, HalfSum, NewSum, Count + 1)
    end.