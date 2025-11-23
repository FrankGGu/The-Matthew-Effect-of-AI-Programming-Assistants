-module(smallestMissing).
-export([smallestMissingNonnegativeIntegerAfterOperations/2]).

smallestMissingNonnegativeIntegerAfterOperations(Nums, Value) ->
    Len = length(Nums),
    Counts = array:new(Value, [0]),
    lists:foreach(fun(Num) ->
                      Index = Num rem Value,
                      array:set(Index, array:get(Index, Counts) + 1, Counts)
                  end, Nums),
    findSmallestMissing(Counts, Value, 0, Len).

findSmallestMissing(Counts, Value, Curr, Len) ->
    Index = Curr rem Value,
    Count = array:get(Index, Counts),
    if Count > 0 ->
        array:set(Index, Count - 1, Counts),
        findSmallestMissing(Counts, Value, Curr + 1, Len);
    true ->
        Curr
    end.