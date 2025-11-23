-module(solution).
-export([max_value/3]).

max_value(N, T, A) ->
    max_value(N, T, A, 0, 0).

max_value(_, 0, _, Sum, _) -> 
    Sum;
max_value(N, T, A, Sum, Pos) when Pos < N -> 
    max_value(N, T - 1, A, Sum + lists:nth(Pos + 1, A), Pos + 1);
max_value(N, T, A, Sum, Pos) -> 
    max_value(N, T, A, Sum, 0).