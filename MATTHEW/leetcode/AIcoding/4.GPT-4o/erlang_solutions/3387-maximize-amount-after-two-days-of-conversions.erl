-module(solution).
-export([maximize_amount/1]).

maximize_amount(N) when N > 0 ->
    maximize_amount(N, 0, 0, 0).

maximize_amount(0, A, B, C) ->
    max(A, max(B, C));
maximize_amount(N, A, B, C) ->
    maximize_amount(N - 1, A + N, B, C + N).

max(X, Y) when X > Y -> X;
max(_, Y) -> Y.