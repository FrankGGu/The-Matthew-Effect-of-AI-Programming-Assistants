-module(solution).
-export([number_of_sequences/3]).

number_of_sequences(N, L, R) ->
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(1, 1, DP),
    DP2 = fill_dp(2, N, L, R, DP1),
    array:get(N, DP2).

fill_dp(I, N, _, _, DP) when I > N -> DP;
fill_dp(I, N, L, R, DP) ->
    Low = max(1, I - R + 1),
    High = min(I - 1, I - L + 1),
    Sum = case High >= Low of
              true -> sum_range(DP, Low, High);
              false -> 0
          end,
    Prev = array:get(I - 1, DP),
    NewVal = (Prev + Sum) rem 1000000007,
    NewDP = array:set(I, NewVal, DP),
    fill_dp(I + 1, N, L, R, NewDP).

sum_range(DP, Low, High) ->
    sum_range(DP, Low, High, 0).

sum_range(_, Low, High, Acc) when Low > High -> Acc;
sum_range(DP, Low, High, Acc) ->
    Val = array:get(Low, DP),
    sum_range(DP, Low + 1, High, (Acc + Val) rem 1000000007).