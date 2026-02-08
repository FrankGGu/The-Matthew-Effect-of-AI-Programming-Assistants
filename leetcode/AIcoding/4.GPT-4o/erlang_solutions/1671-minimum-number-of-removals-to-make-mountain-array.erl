-module(solution).
-export([minimum_removals/1]).

minimum_removals(A) ->
    N = length(A),
    if N < 3 -> 0;
       true -> 
           L = lis(A),
           R = lis(lists:reverse(A)),
           Max = lists:max(lists:zipwith(fun(X, Y) -> X + Y end, L, R)),
           N - Max
    end.

lis(A) ->
    N = length(A),
    L = lists:duplicate(N, 1),
    lis_helper(A, L, 0, N).

lis_helper(_, L, I, N) when I >= N -> L;
lis_helper(A, L, I, N) ->
    L1 = lists:foldl(fun(X, Acc, J) ->
        if A I < X -> lists:update_element(J + 1, Acc, lists:nth(J + 1, Acc) + 1);
           true -> Acc
        end
    end, L, lists:seq(1, I)),
    lis_helper(A, L1, I + 1, N).