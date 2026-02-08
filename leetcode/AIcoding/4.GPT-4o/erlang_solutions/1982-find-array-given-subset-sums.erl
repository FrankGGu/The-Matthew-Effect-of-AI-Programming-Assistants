-module(solution).
-export([find_array/1]).

find_array(Sums) ->
    N = length(Sums) div 2,
    SumsSorted = lists:sort(Sums),
    find_array_helper(SumsSorted, N, []).

find_array_helper(Sums, N, Acc) when length(Acc) == N ->
    Acc;
find_array_helper(Sums, N, Acc) ->
    case Sums of
        [] -> [];
        [H|T] ->
            NewAcc = [H | Acc],
            NewSums = lists:filter(fun(X) -> X =\= H end, T),
            find_array_helper(NewSums, N, NewAcc)
    end.