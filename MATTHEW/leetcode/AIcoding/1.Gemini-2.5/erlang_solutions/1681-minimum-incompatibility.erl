-module(solution).
-export([minimumIncompatibility/2]).

minimumIncompatibility(Nums, K) ->
    N = length(Nums),
    SubsetSize = N div K,
    SortedNums = lists:sort(Nums),
    NumsArray = array:from_list(SortedNums),

    MaxMask = (1 bsl N) - 1,
    Infinity = 1_000_000_000, % A sufficiently large number

    % Dp[mask] = min incompatibility for elements in mask
    Dp = array:new([{size, MaxMask + 1}, {default, Infinity}]),
    Dp1 = array:set(0, 0, Dp),

    % Precompute costs for all valid subsets of size SubsetSize
    % costs[submask] = incompatibility if valid, else Infinity
    PrecomputedCosts = precompute_subset_costs(MaxMask, N, SubsetSize, NumsArray, Infinity),

    FinalDp = solve_dp(0, MaxMask, N, SubsetSize, Dp1, PrecomputedCosts, Infinity),

    Result = array:get(MaxMask, FinalDp),
    case Result of
        Infinity -> -1;
        _ -> Result
    end.

precompute_subset_costs(MaxMask, N, SubsetSize, NumsArray, Infinity) ->
    InitialCosts = array:new([{size, MaxMask + 1}, {default, Infinity}]),
    precompute_subset_costs_iter(0, MaxMask, N, SubsetSize, NumsArray, InitialCosts, Infinity).

precompute_subset_costs_iter(Mask, MaxMask, N, SubsetSize, NumsArray, Costs, Infinity) ->
    if Mask > MaxMask -> Costs;
       true ->
            NewCosts = if popcount(Mask) == SubsetSize ->
                Elements = get_elements_from_mask(Mask, NumsArray, N),
                case calculate_incompatibility(Elements, SubsetSize) of
                    {ok, Inc} ->
                        array:set(Mask, Inc, Costs);
                    error -> % Duplicates found or other invalid subset
                        Costs
                end;
            true ->
                Costs
            end,
            precompute_subset_costs_iter(Mask + 1, MaxMask, N, SubsetSize, NumsArray, NewCosts, Infinity)
    end.

solve_dp(Mask, MaxMask, N, SubsetSize, Dp, PrecomputedCosts, Infinity) ->
    if Mask > MaxMask -> Dp;
       true ->
            CurrentDpVal = array:get(Mask, Dp),
            if CurrentDpVal == Infinity ->
                solve_dp(Mask + 1, MaxMask, N, SubsetSize, Dp, PrecomputedCosts, Infinity);
            true ->
                FirstUnsetIdx = find_first_unset_bit(Mask, N),

                if FirstUnsetIdx == -1 -> % All bits are set, nothing more to do for this mask
                    solve_dp(Mask + 1, MaxMask, N, SubsetSize, Dp, PrecomputedCosts, Infinity);
                true ->
                    % Generate all submasks that include FirstUnsetIdx, are disjoint from Mask,
                    % and have SubsetSize elements.

                    % The first bit (1 bsl FirstUnsetIdx) is always included.
                    % We need to choose SubsetSize - 1 more bits from FirstUnsetIdx + 1 to N - 1.
                    Submasks = generate_combinations_from_idx(SubsetSize - 1, FirstUnsetIdx + 1, N - 1, (1 bsl FirstUnsetIdx), []),

                    NewDp = lists:foldl(fun(Submask, AccDp) ->
                        % Submask generated here ensures:
                        % 1. popcount(Submask) == SubsetSize
                        % 2. (Submask band (1 bsl FirstUnsetIdx)) /= 0 (contains FirstUnsetIdx)
                        % 3. (Submask band ((1 bsl FirstUnsetIdx) - 1)) == 0 (FirstUnsetIdx is the smallest bit)

                        % We only need to check if it's disjoint from `Mask`.
                        if (Submask band Mask) == 0 ->
                            Cost = array:get(Submask, PrecomputedCosts),
                            if Cost /= Infinity ->
                                NewMask = Mask bor Submask,
                                OldVal = array:get(NewMask, AccDp),
                                array:set(NewMask, min(OldVal, CurrentDpVal + Cost), AccDp)
                            else
                                AccDp
                            end;
                        true ->
                            AccDp
                        end
                    end, Dp, Submasks),

                    solve_dp(Mask + 1, MaxMask, N, SubsetSize, NewDp, PrecomputedCosts, Infinity)
                end
            end
    end.

popcount(0) -> 0;
popcount(N) -> 1 + popcount(N band (N - 1)).

find_first_unset_bit(Mask, N) ->
    find_first_unset_bit_iter(Mask, 0, N).

find_first_unset_bit_iter(_, Idx, N) when Idx >= N -> -1;
find_first_unset_bit_iter(Mask, Idx, N) ->
    case (Mask band (1 bsl Idx)) of
        0 -> Idx;
        _ -> find_first_unset_bit_iter(Mask, Idx + 1, N)
    end.

get_elements_from_mask(Mask, NumsArray, N) ->
    get_elements_from_mask_iter(Mask, NumsArray, N - 1, []).

get_elements_from_mask_iter(_, _, -1, Acc) -> Acc;
get_elements_from_mask_iter(Mask, NumsArray, Idx, Acc) ->
    case (Mask band (1 bsl Idx)) of
        0 -> get_elements_from_mask_iter(Mask, NumsArray, Idx - 1, Acc);
        _ -> get_elements_from_mask_iter(Mask, NumsArray, Idx - 1, [array:get(Idx, NumsArray) | Acc])
    end.

calculate_incompatibility(Elements, SubsetSize) ->
    case length(Elements) of
        SubsetSize ->
            SortedElements = lists:sort(Elements),
            if is_unique_sorted(SortedElements) ->
                Max = lists:last(SortedElements),
                Min = hd(SortedElements),
                {ok, Max - Min};
            true ->
                error % Duplicates found
            end;
        _ -> % Should not happen if popcount is correct
            error
    end.

is_unique_sorted([]) -> true;
is_unique_sorted([_]) -> true;
is_unique_sorted([H1, H2 | T]) ->
    if H1 == H2 -> false;
       true -> is_unique_sorted([H2 | T])
    end.

generate_combinations_from_idx(0, _, _, CurrentCombination, Acc) ->
    [CurrentCombination | Acc];
generate_combinations_from_idx(NumBitsToChoose, StartIdx, EndIdx, CurrentCombination, Acc) when StartIdx > EndIdx ->
    Acc;
generate_combinations_from_idx(NumBitsToChoose, StartIdx, EndIdx, CurrentCombination, Acc) when (EndIdx - StartIdx + 1) < NumBitsToChoose -> % Not enough bits left to pick
    Acc;
generate_combinations_from_idx(NumBitsToChoose, StartIdx, EndIdx, CurrentCombination, Acc) ->
    % Option 1: Don't include StartIdx
    Acc1 = generate_combinations_from_idx(NumBitsToChoose, StartIdx + 1, EndIdx, CurrentCombination, Acc),

    % Option 2: Include StartIdx
    generate_combinations_from_idx(NumBitsToChoose - 1, StartIdx + 1, EndIdx, CurrentCombination bor (1 bsl StartIdx), Acc1).