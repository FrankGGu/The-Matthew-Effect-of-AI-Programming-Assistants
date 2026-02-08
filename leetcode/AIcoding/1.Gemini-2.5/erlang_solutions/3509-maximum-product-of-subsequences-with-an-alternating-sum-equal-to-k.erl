-module(solution).
-export([max_product_of_subsequences_with_an_alternating_sum_equal_to_k/2]).

-define(K_OFFSET, 2500).
-define(MAX_SUM_ABS, 2500).

max_product_of_subsequences_with_an_alternating_sum_equal_to_k(Nums, K) ->
    N = length(Nums),

    % Memo table is an array of maps.
    % Each map stores results for a given Idx.
    % Key in map: {CurrentSumOffset, IsAddingNext, HasTakenAny}
    % Value in map: {#MaxProd, #MinProd}
    InitialMemo = array:new([{size, N + 1}, {fixed, true}, {default, #{}}]),

    % Try starting with the first chosen element being added (+)
    {Result1, Memo1} = calculate_dp(0, ?K_OFFSET, 1, 0, Nums, K, InitialMemo, N),

    % Try starting with the first chosen element being subtracted (-)
    % Use Memo1 to leverage computations already done for the '+' path
    {Result2, _} = calculate_dp(0, ?K_OFFSET, 0, 0, Nums, K, Memo1, N),

    {MaxProd1, _} = Result1,
    {MaxProd2, _} = Result2,

    FinalMaxProd = lists:max([MaxProd1, MaxProd2]),

    % If no valid subsequence is found and K is not 0, return -1.
    % If K is 0 and the max product is 0, it means either no subsequence
    % or a subsequence with product 0 (e.g., just [0]) was found, which is valid.
    if FinalMaxProd == 0 and K /= 0 ->
        -1;
    true ->
        FinalMaxProd
    end.

calculate_dp(Idx, CurrentSumOffset, IsAddingNext, HasTakenAny, Nums, K, Memo, N) ->
    MapForIdx = array:get(Idx, Memo),
    Key = {CurrentSumOffset, IsAddingNext, HasTakenAny},

    case maps:get(Key, MapForIdx, undefined) of
        undefined ->
            CurrentSum = CurrentSumOffset - ?K_OFFSET,

            {Value, NewMemo} = 
                if Idx == N -> % Base case: Reached end of array
                    Res = if CurrentSum == K and HasTakenAny == 1 -> {#1, #1};
                          else -> {#0, #0} % No valid path or empty subsequence
                          end,
                    {Res, Memo};
                true ->
                    Num = lists:nth(Idx + 1, Nums),

                    % Option 1: Skip current number
                    {MaxProdSkip, MinProdSkip}, Memo1 = 
                        calculate_dp(Idx + 1, CurrentSumOffset, IsAddingNext, HasTakenAny, Nums, K, Memo, N),

                    % Option 2: Take current number
                    NewCurrentSum = if IsAddingNext == 1 -> CurrentSum + Num;
                                     else -> CurrentSum - Num
                                     end,

                    TakeResult = 
                        if abs(NewCurrentSum) > ?MAX_SUM_ABS -> % Sum out of bounds
                            {#0, #0};
                        true ->
                            NewCurrentSumOffset = NewCurrentSum + ?K_OFFSET,
                            NewIsAddingNext = 1 - IsAddingNext, % Toggle sign for next element
                            NewHasTakenAny = 1,

                            {NextMaxProd, NextMinProd}, _Memo2 = 
                                calculate_dp(Idx + 1, NewCurrentSumOffset, NewIsAddingNext, NewHasTakenAny, Nums, K, Memo1, N),

                            if NextMaxProd == 0 and NextMinProd == 0 -> % Path leads to no valid subsequence
                                {#0, #0};
                            true ->
                                Prods = [Num * NextMaxProd, Num * NextMinProd],
                                {lists:max(Prods), lists:min(Prods)}
                            end
                        end,

                    {MaxProdTake, MinProdTake} = TakeResult,

                    % Combine results from skip and take options
                    {lists:max([MaxProdSkip, MaxProdTake]), lists:min([MinProdSkip, MinProdTake])}, _Memo2
                end,

            % Store result in memo table
            MapForIdxUpdated = maps:put(Key, Value, array:get(Idx, NewMemo)),
            {Value, array:set(Idx, MapForIdxUpdated, NewMemo)};
        Value ->
            {Value, Memo}
    end.