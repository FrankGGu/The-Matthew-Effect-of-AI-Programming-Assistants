-module(stone_game_iii).
-export([stone_game_iii/1]).

stone_game_iii(StoneValue) ->
    N = length(StoneValue),
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(N, 0, DP),
    {_, Result} = solve(StoneValue, 0, DP1),
    if
        Result > 0 -> "Alice";
        Result < 0 -> "Bob";
        true -> "Tie"
    end.

solve(StoneValue, I, DP) ->
    case I >= array:size(DP) - 1 of
        true -> {DP, 0};
        false ->
            case array:get(I, DP) of
                0 ->
                    Max = -1000000000,
                    {DP1, Sum} = take_stones(StoneValue, I, 1, 0, Max, DP),
                    {DP2, Sum1} = take_stones(StoneValue, I, 2, Sum, Max, DP1),
                    {DP3, Sum2} = take_stones(StoneValue, I, 3, Sum1, Max, DP2),
                    NewSum = max(Max, Sum2),
                    NewDP = array:set(I, NewSum, DP3),
                    {NewDP, NewSum};
                Value -> {DP, Value}
            end
    end.

take_stones(StoneValue, I, K, Sum, Max, DP) ->
    case I + K > length(StoneValue) of
        true -> {DP, Max};
        false ->
            CurrentSum = lists:sum(lists:sublist(StoneValue, I + 1, K)),
            {DP1, NextSum} = solve(StoneValue, I + K, DP),
            Total = CurrentSum - NextSum,
            NewMax = max(Max, Total),
            {DP1, NewMax}
    end.