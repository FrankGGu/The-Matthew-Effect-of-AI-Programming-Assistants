-module(solution).
-export([kth_smallest_amount/2]).

gcd(0, B) -> B;
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B, MaxCap) when A == 0 or B == 0 -> 0; % Should not happen with positive denominations
lcm(A, B, MaxCap) ->
    G = gcd(A, B),
    Val = (A div G) * B,
    if
        Val > MaxCap -> MaxCap + 1; % Cap if it exceeds MaxCap
        true -> Val
    end.

count_amounts([], AccLCM, NumChosen, Amount) ->
    if NumChosen == 0 -> 0; % Empty set, contributes 0 to the total count
    true ->
        % If AccLCM was capped (meaning it's > Amount) or is truly > Amount,
        % then floor(Amount / AccLCM) is 0.
        if AccLCM > Amount -> 0;
        true ->
            Term = Amount div AccLCM,
            if NumChosen rem 2 == 1 -> Term; % Odd number of elements, add the term
            true -> -Term % Even number of elements, subtract the term
            end
        end
    end;
count_amounts([H | T], AccLCM, NumChosen, Amount) ->
    % Option 1: Exclude the current denomination H from the subset
    ResExclude = count_amounts(T, AccLCM, NumChosen, Amount),

    % Option 2: Include the current denomination H in the subset
    % Calculate the new LCM, capping it at 'Amount' to prevent unnecessary large calculations
    NewAccLCM = lcm(AccLCM, H, Amount),
    ResInclude = count_amounts(T, NewAccLCM, NumChosen + 1, Amount),

    % Sum the results from both options
    ResExclude + ResInclude.

kth_smallest_amount(Denominations, K) ->
    % Smallest possible amount is the smallest denomination.
    MinDenom = lists:min(Denominations),
    % A safe upper bound for the Kth smallest amount.
    % K can be up to 10^9, max denomination up to 200.
    % So High can be up to 2 * 10^11. Erlang handles large integers.
    MaxDenom = lists:max(Denominations),
    High = K * MaxDenom,

    % Perform binary search for the answer.
    % Low: lower bound of search range.
    % High: upper bound of search range.
    % Ans: stores the current best candidate for the Kth smallest amount.
    binary_search(MinDenom, High, High, Denominations, K).

binary_search(Low, High, Ans, Denominations, K) ->
    if Low =< High ->
        Mid = Low + (High - Low) div 2,
        % Count how many unique amounts are less than or equal to Mid.
        % Initial call for count_amounts: empty set (AccLCM=1, NumChosen=0).
        Count = count_amounts(Denominations, 1, 0, Mid),

        % If Count >= K, Mid could be the answer, or a smaller amount could be.
        % We try to find the smallest such Mid.
        if Count >= K ->
            binary_search(Low, Mid - 1, Mid, Denominations, K);
        % If Count < K, Mid is too small, we need a larger amount.
        true ->
            binary_search(Mid + 1, High, Ans, Denominations, K)
        end;
    true ->
        Ans % Return the smallest Mid for which Count >= K
    end.