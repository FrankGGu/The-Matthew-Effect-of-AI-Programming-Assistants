-module(solution).
-export([maximize_total_cost/1]).

maximize_total_cost(Nums) ->
    % Nums is guaranteed to have at least one element.
    [H | T] = Nums,

    % Define a sufficiently small number to represent negative infinity.
    % Max possible sum is 10^5 * 10^9 = 10^14.
    % 1 bsl 60 is approx 1.15 * 10^18, which is sufficient.
    NegInf = -(1 bsl 60),

    % Initial state for the fold:
    % DpAdd: Maximum cost of an alternating subarray ending with H, where H is added.
    %        For the first element, this is just H itself.
    % DpSubtract: Maximum cost of an alternating subarray ending with H, where H is subtracted.
    %             Not possible for the first element, so initialized to NegInf.
    % MaxCost: The overall maximum cost found so far. For the first element, it's H.
    InitialDpAdd = H,
    InitialDpSubtract = NegInf,
    InitialMaxCost = H,

    % Iterate through the rest of the numbers using lists:foldl.
    % The accumulator is {CurrentDpAdd, CurrentDpSubtract, CurrentMaxCost}.
    {_FinalDpAdd, _FinalDpSubtract, FinalMaxCost} = lists:foldl(
        fun(Num, {CurrentDpAdd, CurrentDpSubtract, CurrentMaxCost}) ->
            % Calculate NewDpAdd:
            % An alternating subarray ending with Num (added) can either be:
            % 1. Num itself (starting a new subarray).
            % 2. Extending a previous subarray that ended with CurrentDpSubtract + Num.
            NewDpAdd = max(Num, CurrentDpSubtract + Num),

            % Calculate NewDpSubtract:
            % An alternating subarray ending with Num (subtracted) must extend
            % a previous subarray that ended with CurrentDpAdd - Num.
            NewDpSubtract = CurrentDpAdd - Num,

            % Update the overall maximum cost found so far.
            % We only consider NewDpAdd because NewDpSubtract ends with a subtraction,
            % which is less likely to be the overall maximum unless the numbers are structured
            % in a specific way that makes subtractions beneficial (e.g., small numbers being subtracted).
            % However, since nums[i] >= 1, ending with an addition is generally better or equal.
            % The problem asks for "total cost", which can be negative.
            % The largest value will always be in a DpAdd state.
            NewMaxCost = max(CurrentMaxCost, NewDpAdd),

            {NewDpAdd, NewDpSubtract, NewMaxCost}
        end,
        {InitialDpAdd, InitialDpSubtract, InitialMaxCost},
        T
    ),
    FinalMaxCost.