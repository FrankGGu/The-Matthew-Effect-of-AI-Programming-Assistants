-module(solution).
-export([minimumCost/1]).

minimumCost(S) ->
    N = length(S),

    Cost0 = calculate_total_cost(S, N, $0),
    Cost1 = calculate_total_cost(S, N, $1),

    min(Cost0, Cost1).

calculate_total_cost(S, N, TargetChar) ->
    % Calculate the cost for operations that make s[i] different from s[i+1] for i from 0 to N-2.
    % These operations are independent of the final target character.
    DiffCosts = 
        case S of
            [] -> 0; % Should not happen as N >= 1 per problem constraints
            [Head | Tail] ->
                % Start comparing S[0] (Head) with S[1] (first element of Tail).
                % The index for the first comparison is 0.
                calculate_diff_costs_loop(Tail, 1, Head, 0)
        end,

    % Calculate the cost for the last character s[N-1].
    % This operation depends on the TargetChar.
    LastChar = lists:last(S), % O(N) operation

    LastCharCost = if (LastChar /= TargetChar) -> N; true -> 0 end,

    DiffCosts + LastCharCost.

calculate_diff_costs_loop([], _CurrentIndex, _PrevChar, AccCost) ->
    % Base case: RemainingChars is empty, all pairs (S[i], S[i+1]) for i < N-1 have been processed.
    AccCost;
calculate_diff_costs_loop([CurrentChar | Rest], CurrentIndex, PrevChar, AccCost) ->
    % Compare PrevChar (S[CurrentIndex-1]) with CurrentChar (S[CurrentIndex]).
    % If they are different, an operation at index (CurrentIndex-1) is needed.
    % The cost of this operation is (CurrentIndex-1 + 1) = CurrentIndex.
    NewAccCost = if (PrevChar /= CurrentChar) -> AccCost + CurrentIndex; true -> AccCost end,

    % Recurse for the next pair.
    calculate_diff_costs_loop(Rest, CurrentIndex + 1, CurrentChar, NewAccCost).