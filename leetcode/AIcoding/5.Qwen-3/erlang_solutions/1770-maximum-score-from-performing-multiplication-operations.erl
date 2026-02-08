-module(maximum_score_from_performing_multiplication_operations).
-export([maximumScore/1]).

maximumScore(Numbers) ->
    N = length(Numbers),
    M = length(Numbers),
    DP = array:new(N, {default, 0}),
    maximumScore(Numbers, DP, 0, 0, M).

maximumScore(_, _, _, K, _) when K == 0 ->
    0;
maximumScore(Numbers, DP, Left, Right, K) ->
    Key = Left * 1000 + Right,
    case array:get(Key, DP) of
        undefined ->
            Val1 = lists:nth(Left + 1, Numbers) * lists:nth(1, Numbers),
            Val2 = lists:nth(Right + 1, Numbers) * lists:nth(1, Numbers),
            Res = max(Val1 + maximumScore(Numbers, DP, Left + 1, Right, K - 1),
                      Val2 + maximumScore(Numbers, DP, Left, Right - 1, K - 1)),
            array:set(Key, Res, DP),
            Res;
        V ->
            V
    end.