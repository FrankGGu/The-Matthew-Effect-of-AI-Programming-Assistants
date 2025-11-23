-module(solution).
-export([max_balanced_subseq_sum/1]).

max_balanced_subseq_sum(List) ->
    max_balanced_subseq_sum(List, 0, 0, 0).

max_balanced_subseq_sum([], _, Sum, Max) ->
    Max;
max_balanced_subseq_sum([H | T], Balance, Sum, Max) ->
    NewBalance = Balance + H,
    NewSum = Sum + H,
    NewMax = max(Max, NewSum),
    max_balanced_subseq_sum(T, NewBalance, NewSum, NewMax).