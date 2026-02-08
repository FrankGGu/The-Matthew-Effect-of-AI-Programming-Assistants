-module(maximum_fruits).
-export([max_total_fruits/3]).

max_total_fruits(Fruits, StartPosition, K) ->
    FruitsLength = length(Fruits),
    PrefixSum = calculate_prefix_sum(Fruits),
    max_total_fruits_helper(Fruits, PrefixSum, StartPosition, K, FruitsLength).

max_total_fruits_helper(Fruits, PrefixSum, StartPosition, K, FruitsLength) ->
    MaxFruits = 0,
    for(X <- 0, X =< K, X = X + 1) do
        Y = K - X,
        Left = StartPosition - X,
        Right = StartPosition + Y,

        Left = max(0,Left),
        Right = min(get_max_pos(Fruits), Right),

        if Left =< Right then
            CurrentFruits = get_fruits(PrefixSum, Fruits, Left, Right),
            MaxFruits = max(MaxFruits, CurrentFruits)
        end,

        Left2 = StartPosition - Y,
        Right2 = StartPosition + X,

        Left2 = max(0,Left2),
        Right2 = min(get_max_pos(Fruits), Right2),

        if Left2 =< Right2 then
            CurrentFruits2 = get_fruits(PrefixSum, Fruits, Left2, Right2),
            MaxFruits = max(MaxFruits, CurrentFruits2)
        end
    end,
    MaxFruits.

calculate_prefix_sum(Fruits) ->
    calculate_prefix_sum_helper(Fruits, 0, []).

calculate_prefix_sum_helper([], Acc, Result) ->
    lists:reverse([Acc|Result]);
calculate_prefix_sum_helper([{Pos, Fruit}|Rest], Acc, Result) ->
    calculate_prefix_sum_helper(Rest, Acc + Fruit, [Acc|Result]).

get_fruits(PrefixSum, Fruits, Left, Right) ->
    RightVal = get_prefix_sum_value(PrefixSum, Fruits, Right),
    LeftVal = get_prefix_sum_value(PrefixSum, Fruits, Left - 1),
    RightVal - LeftVal.

get_prefix_sum_value(PrefixSum, Fruits, Pos) ->
    case Pos of
        -1 -> 0;
        _ ->
            Index = get_index_by_pos(Fruits, Pos),
            case Index of
                undefined -> 0;
                _ ->
                    lists:nth(Index + 1, PrefixSum)
            end
    end.

get_index_by_pos(Fruits, Pos) ->
    get_index_by_pos_helper(Fruits, Pos, 0).

get_index_by_pos_helper([], _, _) ->
    undefined;
get_index_by_pos_helper([{FruitPos, _}|Rest], Pos, Index) ->
    if FruitPos == Pos then
        Index
    else
        get_index_by_pos_helper(Rest, Pos, Index + 1)
    end.

get_max_pos(Fruits) ->
    lists:max([Pos || {Pos,_} <- Fruits]).