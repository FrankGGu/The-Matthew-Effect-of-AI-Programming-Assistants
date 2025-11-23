-module(solution).
-export([mergeStones/2]).

mergeStones(Stones, K) ->
    N = length(Stones),

    if
        N == 0 ->
            0;
        K == 1 ->
            case N of
                1 -> 0;
                _ -> -1
            end;
        true -> % K > 1
            if
                (N - 1) rem (K - 1) /= 0 ->
                    -1;
                true ->
                    solve(Stones, K, N)
            end
    end.

solve(Stones, K, N) ->
    % Calculate prefix sums
    % PrefixSum = [0, stones[0], stones[0]+stones[1], ..., sum(stones[0...N-1])]
    % This list will have N+1 elements.
    PrefixSum = lists:foldl(fun(X, Acc) -> Acc ++ [lists:last(Acc) + X] end, [0], Stones),

    % DP table: dp[i][j][m] = min cost to merge stones[i...j] into m piles
    % Using a flat array for DP table: index(i, j, m) = i * N * (K+1) + j * (K+1) + m
    % m ranges from 1 to K.
    N_flat_dim = N,
    K_flat_dim = K + 1, % For 1-indexed m from 1 to K

    % Helper function to get flat index for (I, J, M)
    get_flat_idx(I, J, M) -> I * N_flat_dim * K_flat_dim + J * K_flat_dim + M.

    % Initialize DP table with infinity
    Infinity = 1_000_000_000_000_000, % Sufficiently large number
    DP_Size = N * N_flat_dim * K_flat_dim,
    DP_Initial = array:new(DP_Size, [{default, Infinity}]),

    % Base cases: dp[i][i][1] = 0 (cost to merge a single stone into 1 pile is 0)
    DP1 = lists:foldl(fun(I, CurrentDP) ->
        array:set(get_flat_idx(I, I, 1), 0, CurrentDP)
    end, DP_Initial, lists:seq(0, N - 1)),

    % Main DP loops
    DP_Final = lists:foldl(fun(Len, CurrentDP_Len) -> % Len from 2 to N
        lists:foldl(fun(I, CurrentDP_I) -> % I from 0 to N - Len
            J = I + Len - 1,

            % Compute dp[i][j][m] for m from 2 to K
            CurrentDP_J_m = lists:foldl(fun(M, AccDP_M) -> % M from 2 to K
                % If m > Len, it's impossible to merge Len stones into M piles (where M > Len)
                % If M == Len, cost is 0 (each stone is its own pile)
                if
                    M > Len ->
                        AccDP_M; % Keep Infinity
                    M == Len ->
                        array:set(get_flat_idx(I, J, M), 0, AccDP_M);
                    true -> % M < Len
                        % dp[i][j][m] = min(dp[i][p][m-1] + dp[p+1][j][1]) for p from i to j-1
                        MinCost_M = lists:foldl(fun(P, AccMin) ->
                            Cost_IP_M_minus_1 = array:get(get_flat_idx(I, P, M - 1), AccDP_M),
                            Cost_Pplus1_J_1 = array:get(get_flat_idx(P + 1, J, 1), AccDP_M),
                            min(AccMin, Cost_IP_M_minus_1 + Cost_Pplus1_J_1)
                        end, Infinity, lists:seq(I, J - 1)),
                        array:set(get_flat_idx(I, J, M), MinCost_M, AccDP_M)
                end
            end, CurrentDP_I, lists:seq(2, K)),

            % Compute dp[i][j][1] (merging into a single pile)
            % This step is only possible if (Len - 1) is divisible by (K - 1)
            % Cost is dp[i][j][K] + sum(stones[i...j])
            if
                (Len - 1) rem (K - 1) == 0 ->
                    Cost_IJ_K = array:get(get_flat_idx(I, J, K), CurrentDP_J_m),
                    % Sum_IJ = stones[I] + ... + stones[J]
                    % PrefixSum list is 1-indexed for element access, 0-indexed for stone index
                    % lists:nth(X, List) gets X-th element (1-indexed)
                    % PrefixSum[0] is at index 1, PrefixSum[1] (sum of stones[0]) is at index 2, etc.
                    % So sum(stones[I...J]) = PrefixSum[J+1+1] - PrefixSum[I+1]
                    Sum_IJ = lists:nth(J + 2, PrefixSum) - lists:nth(I + 1, PrefixSum),
                    array:set(get_flat_idx(I, J, 1), Cost_IJ_K + Sum_IJ, CurrentDP_J_m);
                true ->
                    CurrentDP_J_m % dp[i][j][1] remains Infinity
            end
        end, CurrentDP_Len, lists:seq(0, N - Len))
    end, DP1, lists:seq(2, N)),

    Result = array:get(get_flat_idx(0, N - 1, 1), DP_Final),
    if
        Result >= Infinity -> -1; % If still infinity, impossible
        true -> Result
    end.