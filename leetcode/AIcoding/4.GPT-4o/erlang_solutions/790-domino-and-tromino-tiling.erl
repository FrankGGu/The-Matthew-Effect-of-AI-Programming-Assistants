-module(solution).
-export([num_tilings/1]).

num_tilings(N) when N < 3 -> 
    case N of 
        0 -> 1; 
        1 -> 1; 
        2 -> 2 
    end;
num_tilings(N) -> 
    M = 1000000007,
    F = lists:duplicate(N + 1, 0),
    F = lists:replace(F, 0, 1),
    F = lists:replace(F, 1, 1),
    F = lists:replace(F, 2, 2),
    lists:foldl(fun(I, Acc) -> 
        lists:replace(Acc, I, (lists:nth(I - 1, Acc) + lists:nth(I - 2, Acc) * 2) rem M)
    end, F, lists:seq(3, N)),
    lists:nth(N, F).