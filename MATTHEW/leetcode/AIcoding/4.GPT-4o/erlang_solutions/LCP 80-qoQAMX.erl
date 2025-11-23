-module(solution).
-export([evolution/1]).

evolution(N) when N < 1 -> 0;
evolution(N) -> 
    evolution(N, 0, 1).

evolution(0, A, _) -> A;
evolution(N, A, B) -> 
    evolution(N - 1, B, A + B).