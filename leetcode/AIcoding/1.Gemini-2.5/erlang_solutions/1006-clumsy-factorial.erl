-module(solution).
-export([clumsy/1]).

clumsy(N) when N =< 0 -> 0;
clumsy(N) ->
    clumsy_iter(1, N, 0, N, 0, 1).

clumsy_iter(K, MaxN, Sum, LastVal, OpIndex, CurrentOpSign) when K > MaxN - 1 ->
    Sum + CurrentOpSign * LastVal;
clumsy_iter(K, MaxN, Sum, LastVal, OpIndex, CurrentOpSign) ->
    Num = MaxN - K,
    case OpIndex rem 4 of
        0 -> %% '*'
            NewLastVal = LastVal * Num,
            clumsy_iter(K + 1, MaxN, Sum, NewLastVal, OpIndex + 1, CurrentOpSign);
        1 -> %% '/'
            NewLastVal = LastVal div Num,
            clumsy_iter(K + 1, MaxN, Sum, NewLastVal, OpIndex + 1, CurrentOpSign);
        2 -> %% '+'
            NewSum = Sum + CurrentOpSign * LastVal,
            clumsy_iter(K + 1, MaxN, NewSum, Num, OpIndex + 1, 1);
        3 -> %% '-'
            NewSum = Sum + CurrentOpSign * LastVal,
            clumsy_iter(K + 1, MaxN, NewSum, Num, OpIndex + 1, -1)
    end.