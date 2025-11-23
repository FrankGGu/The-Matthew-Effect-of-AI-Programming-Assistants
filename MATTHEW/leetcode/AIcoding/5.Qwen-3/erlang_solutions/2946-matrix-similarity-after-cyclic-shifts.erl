-module(matrix_similarity_after_cyclic_shifts).
-export([are_similar/2]).

are_similar(Matrix, k) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Transposed = transpose(Matrix),
    TransposedSorted = [lists:sort(Row) || Row <- Transposed],
    TransposedSorted == lists:sort(TransposedSorted).

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose([H|T]) ->
    [lists:map(fun(X) -> hd(X) end, [H|T])] ++ transpose([lists:tl(X) || X <- [H|T]]).

transpose(_) -> [].