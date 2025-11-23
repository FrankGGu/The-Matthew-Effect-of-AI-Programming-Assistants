-spec max_value_after_reverse(Nums :: [integer()]) -> integer().
max_value_after_reverse(Nums) ->
    Original = calculate_value(Nums),
    N = length(Nums),
    MaxGain = 0,
    MaxGain1 = case N >= 2 of
        true ->
            lists:max([abs(lists:nth(1, Nums) - lists:nth(K + 1, Nums)) - abs(lists:nth(K, Nums) - lists:nth(K + 1, Nums)) || K <- lists:seq(1, N - 1)]);
        false ->
            0
    end,
    MaxGain2 = case N >= 2 of
        true ->
            lists:max([abs(lists:nth(N, Nums) - lists:nth(K, Nums)) - abs(lists:nth(K + 1, Nums) - lists:nth(K, Nums)) || K <- lists:seq(1, N - 1)]);
        false ->
            0
    end,
    MinMax1 = lists:min([lists:max([lists:nth(I, Nums), lists:nth(I + 1, Nums)]) || I <- lists:seq(1, N - 1)]),
    MaxMin1 = lists:max([lists:min([lists:nth(I, Nums), lists:nth(I + 1, Nums)]) || I <- lists:seq(1, N - 1)]),
    MaxGain3 = 2 * (MaxMin1 - MinMax1),
    MaxTotalGain = lists:max([MaxGain1, MaxGain2, MaxGain3]),
    Original + MaxTotalGain.

calculate_value(List) ->
    calculate_value(List, 0).

calculate_value([_], Acc) ->
    Acc;
calculate_value([A, B | Rest], Acc) ->
    calculate_value([B | Rest], Acc + abs(A - B)).