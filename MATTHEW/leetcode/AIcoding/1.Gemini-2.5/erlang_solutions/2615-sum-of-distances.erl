-module(solution).
-export([sum_distances/1]).

sum_distances(Nums) ->
    N = length(Nums),

    % Step 1: Group indices by value
    % The map will store Value => [Index_k, Index_k-1, ... Index_1] (descending order)
    IndexedNums = lists:zip(lists:seq(0, N-1), Nums),
    GroupedIndicesMap = lists:foldl(
        fun({Index, Value}, AccMap) ->
            maps:update_with(Value, fun(Indices) -> [Index | Indices] end, [Index], AccMap)
        end,
        maps:new(),
        IndexedNums
    ),

    % Step 2: Calculate sums for each group and store results
    % AllResults will be a list of {OriginalIndex, Sum} tuples
    AllResults = lists:flatmap(
        fun({_Value, RawIndices}) ->
            % Reverse indices to be in ascending order: [Idx_0, Idx_1, ..., Idx_K-1]
            Indices = lists:reverse(RawIndices),
            K = length(Indices),

            % Calculate prefix sums for Indices.
            % PrefixSums = [P_0, P_1, ..., P_K]
            % where P_0 = 0, P_m = sum(Indices_0 to Indices_m-1)
            PrefixSums = lists:foldl(
                fun(Idx, Acc) ->
                    Acc ++ [lists:last(Acc) + Idx]
                end,
                [0], % P_0 = 0
                Indices
            ),
            TotalSumOfIndices = lists:last(PrefixSums), % This is P_K

            % Iterate through Indices and corresponding prefix sums to calculate distances
            % We need:
            %   Idx_M: The current index from the Indices list
            %   P_M_minus_1: Sum of indices before Idx_M (P[m-1] in 1-based formula)
            %   P_M: Sum of indices up to and including Idx_M (P[m] in 1-based formula)
            %   M_0based: The 0-based index of Idx_M within the Indices list
            lists:zipwith3(
                fun(Idx_M, P_M_minus_1, P_M, M_0based) ->
                    m = M_0based + 1, % Convert to 1-based index for the formula

                    % Formula: (m-1) * Idx_m - P[m-1] + (P[k] - P[m]) - (k-m) * Idx_m
                    % Term1: Sum of (Idx_M - Idx_j) for j < M
                    Term1 = (m - 1) * Idx_M,
                    % Term2: Sum of Idx_j for j < M
                    Term2 = P_M_minus_1,
                    % Term3: Sum of Idx_j for j > M
                    Term3 = TotalSumOfIndices - P_M,
                    % Term4: Sum of (Idx_j - Idx_M) for j > M
                    Term4 = (K - m) * Idx_M,

                    Ans_Idx_M = Term1 - Term2 + Term3 - Term4,
                    {Idx_M, Ans_Idx_M}
                end,
                Indices,
                lists:droplast(PrefixSums), % Corresponds to P[0], P[1], ..., P[K-1]
                lists:tl(PrefixSums),      % Corresponds to P[1], P[2], ..., P[K]
                lists:seq(0, K-1)          % 0-based indices for the current group
            )
        end,
        maps:to_list(GroupedIndicesMap)
    ),

    % Step 3: Sort results by original index and extract values
    SortedResults = lists:sort(fun({IdxA, _}, {IdxB, _}) -> IdxA =< IdxB end, AllResults),
    lists:map(fun({_, Sum}) -> Sum end, SortedResults)
.