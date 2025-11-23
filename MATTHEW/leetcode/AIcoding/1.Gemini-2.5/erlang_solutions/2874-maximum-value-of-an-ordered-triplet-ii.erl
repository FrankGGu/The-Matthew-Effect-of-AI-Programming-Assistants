-module(solution).
-export([maximum_triplet_value/1]).

maximum_triplet_value(Nums) ->
    N = length(Nums),

    % If N < 3, no triplet (i, j, k) exists such that 0 <= i < j < k < N.
    % In this case, the maximum value should be 0.
    % The loop for 'j' will not run if N < 3, so MaxVal will remain 0,
    % correctly handling this edge case.

    % Step 1: Calculate prefix_max
    % prefix_max[idx] stores the maximum value in Nums[0...idx]
    PrefixMax = calculate_prefix_max(Nums),

    % Step 2: Calculate suffix_max
    % suffix_max[idx] stores the maximum value in Nums[idx...N-1]
    SuffixMax = calculate_suffix_max(Nums),

    % Step 3: Iterate 'j' from 1 to N-2 (0-indexed)
    % For each 'j', find the maximum 'nums[i]' for i < j (using PrefixMax[j-1])
    % and maximum 'nums[k]' for k > j (using SuffixMax[j+1]).
    % Initialize MaxVal to 0, as per problem statement.
    MaxVal = calculate_max_triplet(Nums, PrefixMax, SuffixMax, N),
    MaxVal.

calculate_prefix_max(Nums) ->
    lists:foldl(fun(X, Acc) ->
                    case Acc of
                        [] -> [X];
                        [H|_] -> [max(H, X) | Acc]
                    end
                end, [], Nums) |> lists:reverse.

calculate_suffix_max(Nums) ->
    lists:foldr(fun(X, Acc) ->
                    case Acc of
                        [] -> [X];
                        [H|_] -> [max(H, X) | Acc]
                    end
                end, [], Nums).

calculate_max_triplet(Nums, PrefixMax, SuffixMax, N) ->
    % 'J' here represents the 0-indexed position of nums[j]
    % The range for 'j' is 1 to N-2 (inclusive)
    lists:foldl(fun(J, AccMaxVal) ->
                    % Get nums[j]
                    NumJ = lists:nth(J + 1, Nums), % lists:nth is 1-indexed

                    % Get max(nums[i]) for i < j
                    % This corresponds to PrefixMax[j-1]
                    MaxI = lists:nth(J, PrefixMax), 

                    % Get max(nums[k]) for k > j
                    % This corresponds to SuffixMax[j+1]
                    MaxK = lists:nth(J + 2, SuffixMax),

                    CurrentVal = (MaxI - NumJ) * MaxK,
                    max(AccMaxVal, CurrentVal)
                end, 0, lists:seq(1, N - 2)).