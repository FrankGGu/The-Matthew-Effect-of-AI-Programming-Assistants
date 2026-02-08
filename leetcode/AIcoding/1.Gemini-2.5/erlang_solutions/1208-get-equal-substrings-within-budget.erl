-module(solution).
-export([equalSubstring/3]).

equalSubstring(S, T, MaxCost) ->
    Costs = calculate_costs(S, T),
    % Initial state:
    % RemainingCostsForRight: The full list of costs, representing elements to be added to the right of the window.
    % RemainingCostsForLeft: The full list of costs, representing elements that can be removed from the left of the window.
    % MaxCost: The budget.
    % CurrentCost: The sum of costs for the current window.
    % CurrentLength: The length of the current window.
    % MaxLength: The maximum length found so far.
    solve(Costs, Costs, MaxCost, 0, 0, 0).

calculate_costs(S, T) ->
    lists:zipwith(fun(C1, C2) -> abs(C1 - C2) end, S, T).

solve([], _RemainingCostsForLeft, _MaxCost, _CurrentCost, _CurrentLength, MaxLength) ->
    MaxLength;
solve([H_right | T_right], RemainingCostsForLeft, MaxCost, CurrentCost, CurrentLength, MaxLength) ->
    % Expand window to the right
    NewCurrentCost = CurrentCost + H_right,
    NewCurrentLength = CurrentLength + 1,

    % Shrink window from the left if cost exceeds budget
    {FinalRemainingCostsForLeft, FinalCurrentCost, FinalCurrentLength} = 
        adjust_left(RemainingCostsForLeft, NewCurrentCost, NewCurrentLength, MaxCost),

    % Update maximum length
    NewMaxLength = max(MaxLength, FinalCurrentLength),

    % Recurse for the next element on the right
    solve(T_right, FinalRemainingCostsForLeft, MaxCost, FinalCurrentCost, FinalCurrentLength, NewMaxLength).

adjust_left([H_left | T_left], Cost, Length, MaxCost) when Cost > MaxCost ->
    adjust_left(T_left, Cost - H_left, Length - 1, MaxCost);
adjust_left(RemainingCostsForLeft, Cost, Length, _MaxCost) ->
    % Cost is within budget, or RemainingCostsForLeft is empty
    {RemainingCostsForLeft, Cost, Length}.