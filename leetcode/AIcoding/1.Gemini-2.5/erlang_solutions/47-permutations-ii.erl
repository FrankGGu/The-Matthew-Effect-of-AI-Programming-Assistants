-module(solution).
-export([permute/1]).

permute(Nums) ->
    SortedNums = lists:sort(Nums),
    permute_recursive(SortedNums, []).

permute_recursive([], CurrentPermutation) ->
    [CurrentPermutation];
permute_recursive(RemainingNums, CurrentPermutation) ->
    % generate_next(ListToProcess, CurrentPrefix, SeenElementsAtThisLevel, AccumulatorOfResults)
    generate_next(RemainingNums, CurrentPermutation, [], []).

generate_next([], _CurrentPermutation, _SeenElementsAtThisLevel, Acc) ->
    Acc;
generate_next([H|T], CurrentPermutation, SeenElementsAtThisLevel, Acc) ->
    case lists:member(H, SeenElementsAtThisLevel) of
        true ->
            % If H has been seen at this level, skip it to avoid duplicate permutations
            generate_next(T, CurrentPermutation, SeenElementsAtThisLevel, Acc);
        false ->
            % H is a new element for this level
            NewRemaining = delete_first(H, [H|T]), % Remove the first occurrence of H
            ResultsForH = permute_recursive(NewRemaining, CurrentPermutation ++ [H]),
            % Add results for H to accumulator and continue with next element in T
            generate_next(T, CurrentPermutation, [H|SeenElementsAtThisLevel], Acc ++ ResultsForH)
    end.

delete_first(X, [X|T]) -> T;
delete_first(X, [H|T]) -> [H|delete_first(X, T)];
delete_first(_X, []) -> []. % Should not be reached if X is guaranteed to be in the list