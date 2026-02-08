-module(solution).
-export([maximum_value_sum/3]).

maximum_value_sum(_N, Edges, K) ->
    InitialSum = lists:foldl(fun([_U, _V, W], Acc) -> Acc + W end, 0, Edges),

    Deltas = lists:map(fun([_U, _V, W]) -> (W bxor K) - W end, Edges),

    PositiveDeltas = lists:filter(fun(D) -> D > 0 end, Deltas),
    NonPositiveDeltas = lists:filter(fun(D) -> D <= 0 end, Deltas),

    CurrentDeltaSum = lists:foldl(fun(D, Acc) -> Acc + D end, 0, PositiveDeltas),
    NumOddOpsEdges = length(PositiveDeltas),

    if (NumOddOpsEdges rem 2) == (K rem 2) ->
        InitialSum + CurrentDeltaSum;
    else
        % We need to change the parity of NumOddOpsEdges.
        % This means we either:
        % 1. Change one edge that currently has an odd number of operations
        %    to have an even number of operations. This means we remove a positive delta.
        %    To maximize the sum, we should remove the smallest positive delta.
        % 2. Change one edge that currently has an even number of operations
        %    to have an odd number of operations. This means we add a non-positive delta.
        %    To maximize the sum, we should add the largest non-positive delta (closest to zero).

        OptionA_DeltaChange = 
            case PositiveDeltas of
                [] -> -infinity; % Cannot remove a positive delta if none exist.
                _ -> -lists:min(PositiveDeltas)
            end,

        OptionB_DeltaChange = 
            case NonPositiveDeltas of
                [] -> -infinity; % Cannot add a non-positive delta if none exist.
                _ -> lists:max(NonPositiveDeltas)
            end,

        FinalDeltaSum = CurrentDeltaSum + erlang:max(OptionA_DeltaChange, OptionB_DeltaChange),
        InitialSum + FinalDeltaSum
    end.