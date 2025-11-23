-module(minimize_the_maximum_of_two_arrays).
-export([min_max_diff/2]).

min_max_diff(A, B) ->
    N = length(A),
    M = length(B),
    S1 = lists:sum(A),
    S2 = lists:sum(B),
    Max1 = lists:max(A),
    Max2 = lists:max(B),
    Min1 = lists:min(A),
    Min2 = lists:min(B),
    T1 = S1 - Max1 + Min1,
    T2 = S2 - Max2 + Min2,
    max(T1, T2).

max(X, Y) when X >= Y -> X;
max(X, Y) -> Y.