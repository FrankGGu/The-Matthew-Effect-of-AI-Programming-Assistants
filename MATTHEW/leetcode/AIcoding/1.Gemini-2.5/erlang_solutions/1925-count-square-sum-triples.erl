-module(solution).
-export([countTriples/1]).

countTriples(N) ->
    countTriples_loop(1, 1, N, 0).

countTriples_loop(A, B, N, Count) when A > N ->
    Count;
countTriples_loop(A, B, N, Count) when B > N ->
    countTriples_loop(A + 1, 1, N, Count);
countTriples_loop(A, B, N, Count) ->
    C_squared = A*A + B*B,
    C_float = math:sqrt(C_squared),
    C_int = round(C_float),
    NewCount = if
        C_int * C_int == C_squared andalso C_int =< N ->
            Count + 1;
        true ->
            Count
    end,
    countTriples_loop(A, B + 1, N, NewCount).