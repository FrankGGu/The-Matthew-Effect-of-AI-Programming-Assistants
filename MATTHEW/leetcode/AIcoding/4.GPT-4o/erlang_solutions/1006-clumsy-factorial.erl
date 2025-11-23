-module(solution).
-export([clumsy/1]).

clumsy(N) when N =< 2 -> N;
clumsy(N) -> 
    clumsy_helper(N, 0, 1).

clumsy_helper(N, Sum, Mult) when N =< 2 -> 
    Sum + Mult * N;
clumsy_helper(N, Sum, Mult) -> 
    NewSum = Sum + Mult * N,
    case N rem 4 of
        0 -> clumsy_helper(N - 1, NewSum, 1);
        1 -> clumsy_helper(N - 2, NewSum, Mult * (N - 1));
        2 -> clumsy_helper(N - 3, NewSum, Mult * (N - 1) div (N - 2));
        _ -> clumsy_helper(N - 4, NewSum, Mult * (N - 1) div (N - 2) * (N - 3))
    end.