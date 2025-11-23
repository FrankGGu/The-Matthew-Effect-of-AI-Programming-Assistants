-module(solution).
-export([max_subarray_sum_with_length_divisible_by_k/2]).

infinity_val() -> 1000000000000.

neg_infinity_val() -> -1000000000000.

max_subarray_sum_with_length_divisible_by_k(Nums, K) ->
    % The problem asks for the maximum subarray sum nums[i...j] such that its length (j-i+1) is divisible by K.
    % Let S[p] be the prefix sum of nums[0...p-1], with S[0] = 0.
    % The sum of nums[i...j] is S[j+1] - S[i].
    % The length is (j+1) - i.
    % We need ((j+1) - i) rem K == 0, which implies (j+1) rem K == i rem K.
    % To maximize S[j+1] - S[i] for a fixed j (and thus fixed S[j+1] and (j+1) rem K),
    % we need to find the minimum S[i] such that i < j+1 and i rem K == (j+1) rem K.

    % Initial state for the fold:
    % max_sum: Stores the maximum subarray sum found so far, initialized to negative infinity.
    % current_prefix_sum: The prefix sum up to the current element being processed, initialized to 0 (S[0]).
    % min_prefix_sums: A map where keys are remainders (0 to K-1) and values are
    %                  the minimum prefix sum S[x] encountered so far such that x rem K == remainder.
    %                  S[0] = 0, and 0 rem K = 0, so initialize the map with {0 => 0}.
    %                  Other remainders are implicitly infinity_val() until a prefix sum with that remainder is seen.

    InitialMinPrefixSums = #{0 => 0}, % S[0] = 0, and 0 mod K = 0

    InitialAcc = #{
        max_sum => neg_infinity_val(),
        current_prefix_sum => 0,
        min_prefix_sums => InitialMinPrefixSums
    },

    % Iterate through the numbers using lists:foldl to maintain the accumulator state.
    FinalAcc = lists:foldl(
        fun(Num, Acc) ->
            CurrentPS = Acc.current_prefix_sum,
            MaxS = Acc.max_sum,
            MinPSMap = Acc.min_prefix_sums,

            NewPS = CurrentPS + Num, % Calculate the new prefix sum (S[p] for current p)

            % Calculate the remainder of NewPS when divided by K.
            % (X rem K + K) rem K ensures the result is always non-negative (0 to K-1).
            Remainder = (NewPS rem K + K) rem K,

            % Get the minimum prefix sum seen so far that has the same remainder.
            % If the remainder key is not in the map, it means no such prefix sum has been
            % encountered yet, so we treat its value as infinity_val().
            MinValForRem = maps:get(Remainder, MinPSMap, infinity_val()),

            NewMaxS = 
                case MinValForRem of
                    infinity_val() -> MaxS; % No valid starting point found yet for this remainder
                    _ -> max(MaxS, NewPS - MinValForRem) % Update max_sum if a larger sum is found
                end,

            % Update min_prefix_sums map for the current remainder.
            % We only store the minimum prefix sum for each remainder.
            OldMinValForRem = maps:get(Remainder, MinPSMap, infinity_val()),
            UpdatedMinPSMap = maps:put(Remainder, min(OldMinValForRem, NewPS), MinPSMap),

            % Return the updated accumulator.
            Acc#{
                max_sum => NewMaxS,
                current_prefix_sum => NewPS,
                min_prefix_sums => UpdatedMinPSMap
            }
        end,
        InitialAcc,
        Nums
    ),

    % The final maximum subarray sum is stored in the max_sum field of the final accumulator.
    FinalAcc.max_sum.