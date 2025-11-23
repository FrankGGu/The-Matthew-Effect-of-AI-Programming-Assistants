-module(solution).
-export([monotonic_pairs/1]).

monotonic_pairs(A) ->
    N = length(A),
    Count = monotonic_pairs_count(A, N),
    Count.

monotonic_pairs_count(A, N) ->
    count_increasing(A, N) + count_decreasing(A, N).

count_increasing(A, N) ->
    count_pairs(A, N, fun(X, Y) -> X =< Y end).

count_decreasing(A, N) ->
    count_pairs(A, N, fun(X, Y) -> X >= Y end).

count_pairs(A, N, Predicate) ->
    Pairs = lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc1) -> 
            if Predicate(X, Y) -> 
                Acc1 + 1; 
            true -> 
                Acc1 
            end 
        end, Acc, A) 
    end, 0, A),
    Pairs.