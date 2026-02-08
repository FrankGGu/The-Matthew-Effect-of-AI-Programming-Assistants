-module(solution).
-export([maxOperations/1]).

maxOperations([H1, H2 | T]) ->
    Score = H1 + H2,
    maxOperationsHelper(T, Score, 1);
maxOperations(_) ->
    0.

maxOperationsHelper([H1, H2 | T], Score, Count) ->
    if
        H1 + H2 =:= Score ->
            maxOperationsHelper(T, Score, Count + 1);
        true ->
            Count
    end;
maxOperationsHelper(_, _, Count) ->
    Count.