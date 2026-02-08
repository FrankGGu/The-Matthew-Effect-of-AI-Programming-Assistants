-module(solution).
-export([transformed_array/4]).

transformed_array(Nums, A, B, C) ->
    N = length(Nums),
    if
        N == 0 -> [];
        A == 0 ->
            % Linear function: f(x) = bx + c
            Transformed = lists:map(fun(X) -> B * X + C end, Nums),
            if
                B >= 0 -> Transformed; % If b >= 0, it's non-decreasing
                true -> lists:reverse(Transformed) % If b < 0, it's non-increasing, so reverse to sort ascending
            end;
        true ->
            % Quadratic function: f(x) = ax^2 + bx + c
            % Convert Nums to an array for O(1) element access
            NumArray = array:from_list(Nums),
            ResultArray = array:new([{size, N}]), % Initialize an empty array for results

            % Helper function to calculate f(x)
            F = fun(X_val) -> A * X_val * X_val + B * X_val + C end,

            if
                A > 0 ->
                    % Parabola opens upwards. Minimum value is at the vertex.
                    % Maximum values are at the ends of the input range.
                    % Use two pointers to fill the result array from right to left (largest to smallest).
                    solve_a_pos(NumArray, F, 0, N - 1, N - 1, ResultArray);
                true -> % A < 0
                    % Parabola opens downwards. Maximum value is at the vertex.
                    % Minimum values are at the ends of the input range.
                    % Use two pointers to fill the result array from left to right (smallest to largest).
                    solve_a_neg(NumArray, F, 0, N - 1, 0, ResultArray)
            end
    end.

solve_a_pos(NumArray, F, Left, Right, K, ResultArray) when Left =< Right ->
    ValLeft = F(array:get(Left, NumArray)),
    ValRight = F(array:get(Right, NumArray)),
    if
        ValLeft > ValRight ->
            NewResultArray = array:set(K, ValLeft, ResultArray),
            solve_a_pos(NumArray, F, Left + 1, Right, K - 1, NewResultArray);
        true -> % ValRight >= ValLeft
            NewResultArray = array:set(K, ValRight, ResultArray),
            solve_a_pos(NumArray, F, Left, Right - 1, K - 1, NewResultArray)
    end;
solve_a_pos(_NumArray, _F, _Left, _Right, _K, ResultArray) ->
    array:to_list(ResultArray).

solve_a_neg(NumArray, F, Left, Right, K, ResultArray) when Left =< Right ->
    ValLeft = F(array:get(Left, NumArray)),
    ValRight = F(array:get(Right, NumArray)),
    if
        ValLeft < ValRight ->
            NewResultArray = array:set(K, ValLeft, ResultArray),
            solve_a_neg(NumArray, F, Left + 1, Right, K + 1, NewResultArray);
        true -> % ValRight <= ValLeft
            NewResultArray = array:set(K, ValRight, ResultArray),
            solve_a_neg(NumArray, F, Left, Right - 1, K + 1, NewResultArray)
    end;
solve_a_neg(_NumArray, _F, _Left, _Right, _K, ResultArray) ->
    array:to_list(ResultArray).