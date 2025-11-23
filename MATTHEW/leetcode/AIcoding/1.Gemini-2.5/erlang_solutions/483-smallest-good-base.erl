-module(solution).
-export([smallestGoodBase/1]).

smallestGoodBase(N_str) ->
    N_val = binary_to_integer(N_str),

    % Iterate 'm' from max possible value down to 1.
    % Max 'm' for N_val = 10^18 is 59 (since 2^60 > 10^18).
    % Using 60 as a safe upper bound for 'm'.
    find_base(N_val, 60).

find_base(N_val, M) when M < 1 ->
    % This case should ideally not be reached, as M=1 (k=N_val-1) is always a solution.
    integer_to_binary(N_val - 1);
find_base(N_val, M) ->
    % Binary search for K in the range [2, N_val - 1].
    % High bound for K can be N_val-1.
    % For M=1, K = N_val-1.
    High = N_val - 1,
    Low = 2,

    case binary_search_k(N_val, M, Low, High) of
        {found, K} -> integer_to_binary(K);
        not_found -> find_base(N_val, M - 1) % No K found for this M, try next smaller M
    end.

binary_search_k(_N_val, _M, Low, High) when Low > High -> not_found;
binary_search_k(N_val, M, Low, High) ->
    K = Low + (High - Low) div 2, % Calculate midpoint K

    Sum = calculate_sum(K, M, N_val),

    if Sum == N_val ->
        {found, K};
    else if Sum < N_val ->
        binary_search_k(N_val, M, K + 1, High); % K is too small, search in upper half
    else % Sum > N_val (or overflowed during calculation)
        binary_search_k(N_val, M, Low, K - 1)  % K is too large, search in lower half
    end.

calculate_sum(K, M, N_val) ->
    calculate_sum_iter(K, M, N_val, 0, 1).

calculate_sum_iter(_K, M, _N_val, CurrentSum, _Power) when M < 0 -> CurrentSum;
calculate_sum_iter(K, M, N_val, CurrentSum, Power) ->
    % Check if adding Power to CurrentSum would exceed N_val.
    % If Power > N_val - CurrentSum, then CurrentSum + Power > N_val.
    if Power > N_val - CurrentSum ->
        N_val + 1; % Indicate sum is too large
    else
        NewCurrentSum = CurrentSum + Power,
        % If M > 0, we need to calculate the next power term (Power * K).
        % Check if Power * K would exceed N_val.
        % This is equivalent to checking if Power > N_val / K.
        if M > 0 ->
            % K is always >= 2 in this context.
            if Power > N_val div K -> % Check if Power * K would exceed N_val
                N_val + 1; % Indicate sum is too large
            else
                NewPower = Power * K,
                calculate_sum_iter(K, M - 1, N_val, NewCurrentSum, NewPower)
            end
        else % M == 0, this was the last term (K^0 = 1), no more power multiplication needed.
            NewCurrentSum
        end
    end.