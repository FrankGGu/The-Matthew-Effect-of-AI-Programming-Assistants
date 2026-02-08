-module(solution).
-export([min_or_of_remaining_elements/2]).

min_or_of_remaining_elements(Nums, K) ->
    % The maximum possible value for an element is 10^9, which is less than 2^30.
    % So, the maximum possible OR sum will also be less than 2^30.
    % We can use (1 bsl 30) - 1 as a sufficiently large upper bound for binary search.
    MaxPossibleOR = (1 bsl 30) - 1,

    % Binary search for the minimum achievable OR sum.
    % Low: 0 (minimum possible OR sum)
    % High: MaxPossibleOR (maximum possible OR sum)
    % Ans: Stores the smallest OR sum found so far that is achievable.
    binary_search(0, MaxPossibleOR, MaxPossibleOR, Nums, K).

binary_search(Low, High, Ans, Nums, K) ->
    if
        Low > High -> 
            Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            case check(Mid, Nums, K) of
                true ->
                    % If Mid is achievable, try to find an even smaller OR sum.
                    binary_search(Low, Mid - 1, Mid, Nums, K);
                false ->
                    % If Mid is not achievable, we need a larger OR sum.
                    binary_search(Mid + 1, High, Ans, Nums, K)
            end
    end.

check(TargetOR, Nums, K) ->
    OpsCount = 
        lists:foldl(
            fun(Num, Acc) ->
                % An operation is needed if Num has any bit set that is NOT set in TargetOR.
                % (Num band (bnot TargetOR)) will be non-zero if Num has such bits.
                if
                    (Num band (bnot TargetOR)) == 0 -> Acc;
                    true -> Acc + 1
                end
            end,
            0,
            Nums
        ),

    if
        OpsCount > K -> 
            % Not enough operations to make all numbers compatible with TargetOR.
            false;
        true ->
            % If operations are sufficient, calculate the actual OR sum after modifications.
            FinalORSum = 
                lists:foldl(
                    fun(Num, Acc) ->
                        if
                            (Num band (bnot TargetOR)) == 0 -> 
                                % No operation needed for this Num, it's already compatible.
                                Acc bor Num;
                            true -> 
                                % Operation needed, modify Num to be a submask of TargetOR.
                                Acc bor (Num band TargetOR)
                        end
                    end,
                    0,
                    Nums
                ),

            % The TargetOR is achievable only if the actual OR sum of the modified array
            % is exactly equal to TargetOR.
            FinalORSum == TargetOR
    end.