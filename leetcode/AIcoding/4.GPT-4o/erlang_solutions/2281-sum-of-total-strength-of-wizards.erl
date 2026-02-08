-module(solution).
-export([total_strength/1]).

total_strength(Wizards) ->
    N = length(Wizards),
    PrefixSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Wizards),
    PrefixSumRev = lists:reverse(PrefixSum),
    Strengths = lists:map(fun(X) -> sum_strength(X, PrefixSumRev) end, Wizards),
    lists:sum(Strengths) rem 1000000007.

sum_strength(X, PrefixSumRev) ->
    case lists:find_index(fun(Y) -> Y >= X end, PrefixSumRev) of
        none -> 0;
        {ok, Index} -> 
            Left = lists:nth(Index + 1, PrefixSumRev),
            Right = lists:nth(Index + 2, PrefixSumRev),
            (Left + Right) * X
    end.