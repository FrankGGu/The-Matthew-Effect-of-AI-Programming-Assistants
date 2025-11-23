-module(solution).
-export([max_strength/2]).

max_strength(Nums, K) ->
    % Inf represents negative infinity, used for unreachable states.
    % Erlang's arbitrary precision integers handle large values.
    Inf = -(1 bsl 100), 

    % DpNotTaken[j] stores the maximum strength of 'j' subarrays using elements
    % up to the current one, where the current element is NOT part of the j-th subarray.
    % DpTaken[j] stores the maximum strength of 'j' subarrays using elements
    % up to the current one, where the current element IS part of the j-th subarray.
    % Both are arrays of size K+1.
    % Initialize DpNotTaken[0] to 0 (0 subarrays, 0 strength). All other elements to Inf.
    % Initialize DpTaken[0] to Inf (cannot form 0 subarrays by taking an element). All other elements to Inf.
    DpNotTaken = array:set(0, 0, array:new({size, K + 1}, {default, Inf})),
    DpTaken = array:new({size, K + 1}, {default, Inf}),

    % Iterate through each number in the input list Nums
    {FinalDpNotTaken, FinalDpTaken} = lists:foldl(
        fun(Num, {PrevDpNotTaken, PrevDpTaken}) ->
            % Create new arrays for the current iteration
            % NewDpNotTaken[0] must remain 0. NewDpTaken[0] must remain Inf.
            NewDpNotTaken = array:set(0, 0, array:new({size, K + 1}, {default, Inf})),
            NewDpTaken = array:new({size, K + 1}, {default, Inf}),

            % Iterate for 'j' (number of subarrays) from 1 to K
            lists:foldl(
                fun(J, {CurrDpNotTakenAcc, CurrDpTakenAcc}) ->
                    % Calculate the coefficient for the j-th subarray
                    Coeff = J * (if J rem 2 == 1 then 1 else -1),

                    % Calculate NewDpNotTaken[J]:
                    % Max strength of J subarrays ending BEFORE current element.
                    % This can come from either:
                    % 1. J subarrays formed, previous element was NOT taken (PrevDpNotTaken[J])
                    % 2. J subarrays formed, previous element WAS taken (PrevDpTaken[J])
                    ValNotTaken = max(array:get(J, PrevDpNotTaken), array:get(J, PrevDpTaken)),
                    CurrDpNotTakenAcc_updated = array:set(J, ValNotTaken, CurrDpNotTakenAcc),

                    % Calculate NewDpTaken[J]:
                    % Max strength of J subarrays ending AT current element.
                    % This can come from either:
                    % 1. Extending the J-th subarray that ended at the previous element (PrevDpTaken[J] + Num * Coeff)
                    % 2. Starting a new J-th subarray after J-1 subarrays were formed,
                    %    where the (J-1)-th subarray either ended BEFORE the previous element
                    %    (array:get(J - 1, PrevDpNotTaken) + Num * Coeff)
                    %    or ended AT the previous element (array:get(J - 1, PrevDpTaken) + Num * Coeff)
                    ValExtend = array:get(J, PrevDpTaken) + Num * Coeff,
                    ValStartNewAfterNotTaken = array:get(J - 1, PrevDpNotTaken) + Num * Coeff,
                    ValStartNewAfterTaken = array:get(J - 1, PrevDpTaken) + Num * Coeff,

                    ValTaken = max(ValExtend, max(ValStartNewAfterNotTaken, ValStartNewAfterTaken)),
                    CurrDpTakenAcc_updated = array:set(J, ValTaken, CurrDpTakenAcc),

                    {CurrDpNotTakenAcc_updated, CurrDpTakenAcc_updated}
                end,
                {NewDpNotTaken, NewDpTaken}, % Initial accumulators for the inner fold
                lists:seq(1, K) % Iterate for J from 1 to K
            )
        end,
        {DpNotTaken, DpTaken}, % Initial state for the outer fold (before processing any numbers)
        Nums
    ),

    % The final answer is the maximum of DpNotTaken[K] and DpTaken[K]
    % after processing all numbers.
    max(array:get(K, FinalDpNotTaken), array:get(K, FinalDpTaken)).