-module(solution).
-export([findIndices/2]).

findIndices(Nums, indexDiff) ->
    findIndices(Nums, indexDiff, 0, length(Nums) - 1).

findIndices(_, _, Start, End) when Start > End ->
    [];
findIndices(Nums, IndexDiff, Start, End) ->
    N = length(Nums),
    I = Start,
    J = Start + IndexDiff,
    if
        J < N ->
            if
                element(I + 1, Nums) <= element(J + 1, Nums) ->
                    [I];
                true ->
                    findIndices(Nums, IndexDiff, Start + 1, End)
            end;
        true ->
            findIndices(Nums, IndexDiff, Start + 1, End)
    end.