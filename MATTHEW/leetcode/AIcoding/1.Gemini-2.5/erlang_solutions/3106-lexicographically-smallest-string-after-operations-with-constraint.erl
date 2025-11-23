-module(solution).
-export([smallestString/2]).

smallestString(S, K) ->
    smallestString_recursive(S, K, []).

smallestString_recursive([], _K, Acc) ->
    lists:reverse(Acc);
smallestString_recursive([H|T], K, Acc) ->
    CharVal = H - $a,
    CostToA = min(CharVal, 26 - CharVal),
    if
        K >= CostToA ->
            NewK = K - CostToA,
            smallestString_recursive(T, NewK, [$a | Acc]);
        true -> % K < CostToA
            NewCharVal = (CharVal - K) mod 26,
            NewChar = NewCharVal + $a,
            lists:reverse([NewChar | Acc]) ++ T
    end.