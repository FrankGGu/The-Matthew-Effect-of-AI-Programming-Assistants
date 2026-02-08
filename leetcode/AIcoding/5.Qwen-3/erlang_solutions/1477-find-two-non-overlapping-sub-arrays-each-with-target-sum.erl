-module(solution).
-export([min_sum_of_two_subarrays/2]).

min_sum_of_two_subarrays(S, T) ->
    N = length(S),
    Left = array:new([{size, N}, {default, 0}]),
    Right = array:new([{size, N}, {default, 0}]),
    I = 1,
    Sum = 0,
    Pos = 0,
    MinSum = infinity,
    min_sum_of_two_subarrays(S, T, N, I, Sum, Pos, Left, Right, MinSum).

min_sum_of_two_subarrays(_, _, _, _, _, _, _, _, MinSum) when MinSum /= infinity ->
    MinSum;

min_sum_of_two_subarrays(S, T, N, I, Sum, Pos, Left, Right, MinSum) ->
    if
        I > N ->
            MinSum;
        true ->
            NewSum = Sum + lists:nth(I, S),
            case NewSum of
                _ when NewSum == T ->
                    ArrayPos = I - 1,
                    array:set(ArrayPos, I, Left),
                    NewMin = min(MinSum, I),
                    min_sum_of_two_subarrays(S, T, N, I + 1, 0, 0, Left, Right, NewMin);
                _ ->
                    min_sum_of_two_subarrays(S, T, N, I + 1, NewSum, Pos + 1, Left, Right, MinSum)
            end
    end.