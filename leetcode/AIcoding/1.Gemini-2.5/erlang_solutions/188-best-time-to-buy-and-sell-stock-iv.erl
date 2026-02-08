-module(solution).
-export([maxProfit/2]).

max(A, B) when A >= B -> A;
max(A, B) -> B.

unlimited_profit([]) -> 0;
unlimited_profit([_]) -> 0; % A single price means no transaction possible
unlimited_profit(Prices) ->
    unlimited_profit_iter(tl(Prices), hd(Prices), 0).

unlimited_profit_iter([], _Prev, Acc) -> Acc;
unlimited_profit_iter([H | T], Prev, Acc) ->
    unlimited_profit_iter(T, H, Acc + max(0, H - Prev)).

dp_step_recursive(_Price, CurrentFree, CurrentHold, 0, AccNewFree, AccNewHold) ->
    % Base case: T = 0 (0 transactions). The 0-th elements (index 1 in 1-based list)
    % are taken directly from the previous state as they don't change by a transaction.
    {lists:nth(1, CurrentFree) :: AccNewFree, lists:nth(1, CurrentHold) :: AccNewHold};
dp_step_recursive(Price, CurrentFree, CurrentHold, T, AccNewFree, AccNewHold) ->
    % T is the current transaction count (1-based index for lists:nth)
    % CurrentHold[T] is lists:nth(T+1, CurrentHold)
    % CurrentFree[T-1] is lists:nth(T, CurrentFree)

    HoldT_val = lists:nth(T+1, CurrentHold),
    FreeT_minus_1_val = lists:nth(T, CurrentFree),

    % Calculate new hold[T]: max(do nothing, buy stock using free[T-1] state)
    UpdatedHoldT = max(HoldT_val, FreeT_minus_1_val - Price),

    FreeT_val = lists:nth(T+1, CurrentFree),
    % Calculate new free[T]: max(do nothing, sell stock using new hold[T] state)
    UpdatedFreeT = max(FreeT_val, UpdatedHoldT + Price),

    % Recurse for T-1, prepending the newly calculated values
    dp_step_recursive(Price, CurrentFree, CurrentHold, T-1, UpdatedFreeT :: AccNewFree, UpdatedHoldT :: AccNewHold).

maxProfit(K, Prices) ->
    N = length(Prices),

    if
        N =< 1 -> 0; % No profit with 0 or 1 prices
        K >= N div 2 -> unlimited_profit(Prices); % If K is large enough, it's equivalent to unlimited transactions
        true ->
            K_eff = K, % Effective K for DP is the given K
            NegInf = -1000000000, % A sufficiently small number for negative infinity

            % Initialize DP states:
            % free[t] = max profit after t transactions, not holding stock
            % hold[t] = max profit after t transactions, holding stock
            % Lists are 1-indexed for convenience (index 0 for 0 transactions, index T for T transactions)
            % So lists have size K_eff+1.
            Free = lists:duplicate(K_eff+1, 0),
            Hold = lists:duplicate(K_eff+1, NegInf),

            % Iterate through each price to update DP states
            {FinalFree, _FinalHold} = lists:foldl(
                fun(Price, {CurrentFree, CurrentHold}) ->
                    % For each price, compute the next state using the recursive helper
                    dp_step(Price, CurrentFree, CurrentHold, K_eff)
                end,
                {Free, Hold}, % Initial DP states
                Prices
            ),

            % The maximum profit is the maximum value in the final 'free' list
            lists:max(FinalFree)
    end.