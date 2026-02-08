-module(solution).
-export([min_increment_operations/2]).

cost(Val, K) ->
    max(0, K - Val).

min_increment_operations(Nums, K) ->
    N = length(Nums),
    case N of
        0 -> 0;
        1 -> 0;
        2 -> 0;
        _ ->
            % Initial dp values: dp[0]=0, dp[1]=0, dp[2]=0
            % These correspond to Dp_i_minus_3, Dp_i_minus_2, Dp_i_minus_1 respectively
            % for the first iteration (calculating dp[3])

            % Initial Nums values: Nums[0], Nums[1], Nums[2]
            % These correspond to N_i_minus_3, N_i_minus_2, N_i_minus_1 respectively
            % for the first iteration (calculating dp[3])
            [N0, N1, N2 | Rest] = Nums,
            solve_dp(Rest, K, 0, 0, 0, N0, N1, N2)
    end.

solve_dp([], _K, _Dp_i_minus_3, _Dp_i_minus_2, Dp_i_minus_1, _N_i_minus_3, _N_i_minus_2, _N_i_minus_1) ->
    % When Rest is empty, we have processed all elements.
    % Dp_i_minus_1 at this point holds the value for dp[N].
    Dp_i_minus_1;
solve_dp([N_i | Rest], K, Dp_i_minus_3, Dp_i_minus_2, Dp_i_minus_1, N_i_minus_3, N_i_minus_2, N_i_minus_1) ->
    % Calculate Current_dp_val (which is dp[i])
    % It's the minimum cost to make Nums[0...i-1] beautiful.
    % It depends on dp[i-1], dp[i-2], dp[i-3] and Nums[i-1], Nums[i-2], Nums[i-3].
    % In this call:
    % Dp_i_minus_1 is dp[i-1]
    % Dp_i_minus_2 is dp[i-2]
    % Dp_i_minus_3 is dp[i-3]
    % N_i_minus_1 is Nums[i-1]
    % N_i_minus_2 is Nums[i-2]
    % N_i_minus_3 is Nums[i-3]

    Val1 = Dp_i_minus_1 + cost(N_i_minus_1, K),
    Val2 = Dp_i_minus_2 + cost(N_i_minus_2, K),
    Val3 = Dp_i_minus_3 + cost(N_i_minus_3, K),
    Current_dp_val = min(Val1, min(Val2, Val3)),

    % Shift values for the next iteration (i+1)
    % The current N_i becomes N_i_minus_1 for the next call.
    % The current Dp_i_minus_1 becomes Dp_i_minus_2 for the next call.
    % The current Current_dp_val becomes Dp_i_minus_1 for the next call.
    solve_dp(Rest, K, Dp_i_minus_2, Dp_i_minus_1, Current_dp_val, N_i_minus_2, N_i_minus_1, N_i).