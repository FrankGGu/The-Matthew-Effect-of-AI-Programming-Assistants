-module(solution).
-export([minChanges/2]).

minChanges(Nums, K) ->
    N = length(Nums),
    MaxXorVal = 1024, % Maximum possible value for nums[i] is 2^10 - 1 = 1023.
                      % The XOR sum can also range from 0 to 1023.

    % Step 1: Group numbers by their column (index mod K) and calculate frequencies.
    % Freqs[Col] will be a map of {Value => Count} for elements in column Col.
    % TotalElements[Col] will be the total count of elements in column Col.
    % Initialize arrays for K columns.
    InitialFreqs = array:new([{fixed, true}, {size, K}, {default, #{}}]),
    InitialTotalElements = array:new([{fixed, true}, {size, K}, {default, 0}]),

    % Fold over the Nums list directly with an index counter to populate Freqs and TotalElements.
    {_FinalIdx, FinalFreqs, FinalTotalElements} =
        lists:foldl(
            fun(Val, {Idx, AccFreqs, AccTotalElements}) ->
                Col = Idx rem K,

                CurrentFreqMap = array:get(Col, AccFreqs),
                NewFreqMap = maps:update_with(Val, fun(C) -> C + 1 end, 1, CurrentFreqMap),

                CurrentTotal = array:get(Col, AccTotalElements),
                NewTotal = CurrentTotal + 1,

                NewAccFreqs = array:set(Col, NewFreqMap, AccFreqs),
                NewAccTotalElements = array:set(Col, NewTotal, AccTotalElements),
                {Idx + 1, NewAccFreqs, NewAccTotalElements}
            end,
            {0, InitialFreqs, InitialTotalElements}, % Initial state: {current_index, freqs_array, total_elements_array}
            Nums
        ),

    % Step 2: Dynamic Programming
    % dp[ColIdx][XorSum] = minimum changes for first ColIdx columns to have XOR sum XorSum.
    % Use a large number for infinity. Max possible changes is N (changing all elements).
    % N is up to 2000, so 10^9 is a safe infinity.
    Infinity = 1000000000, 

    % PrevDp represents dp[ColIdx-1]
    PrevDp = array:new([{fixed, true}, {size, MaxXorVal}, {default, Infinity}]),
    PrevDp = array:set(0, 0, PrevDp), % Base case: dp[0][0] = 0 (0 cost for 0 XOR sum for 0 columns)

    % Iterate through columns from 0 to K-1
    FinalDp = lists:foldl(
        fun(ColIdx, CurrentPrevDp) ->
            CurrentColFreqsMap = array:get(ColIdx, FinalFreqs),
            CurrentColTotalElements = array:get(ColIdx, FinalTotalElements),

            % Calculate min_cost_prev_state: minimum cost from any state in the previous column's DP.
            MinCostPrevState = array:foldl(fun(_Idx, Val, Acc) -> min(Val, Acc) end, Infinity, CurrentPrevDp),

            % Initialize NewDp for the current column (dp[ColIdx]).
            % All states are initially set based on the `MinCostPrevState`. This covers the case where
            % the chosen value for x_ColIdx (the element in the current column) is not present in CurrentColFreqsMap.
            NewDp = array:new([{fixed, true}, {size, MaxXorVal}, {default, Infinity}]),
            NewDpInitialized = array:map(
                fun(_Idx, CurrentVal) -> min(CurrentVal, MinCostPrevState + CurrentColTotalElements) end,
                NewDp
            ),

            % Now, iterate through previous DP states and apply transitions for values that are present in CurrentColFreqsMap.
            array:foldl(
                fun(PrevXorSum, PrevCost, AccDp) ->
                    if PrevCost >= Infinity -> % If previous state is unreachable, skip
                        AccDp;
                    true ->
                        maps:fold(
                            fun(Val, Freq, AccDp2) ->
                                CostForVal = CurrentColTotalElements - Freq, % Cost to make all elements in this column 'Val'
                                NewXorSum = PrevXorSum bxor Val,
                                CurrentNewDpCost = array:get(NewXorSum, AccDp2),
                                array:set(NewXorSum, min(CurrentNewDpCost, PrevCost + CostForVal), AccDp2)
                            end,
                            AccDp,
                            CurrentColFreqsMap
                        )
                    end
                end,
                NewDpInitialized, % Start with the initialized NewDp
                CurrentPrevDp
            )
        end,
        PrevDp, % Initial DP for the first column (ColIdx=0)
        lists:seq(0, K - 1)
    ),

    array:get(0, FinalDp). % The final answer is the minimum cost to achieve an XOR sum of 0 after K columns.