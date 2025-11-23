-module(solution).
-export([equalizeArray/1]).

equalizeArray(Nums) ->
    equalizeArray(Nums, 0).

equalizeArray([], _) ->
    0;
equalizeArray([H | T], Count) ->
    if
        H == 0 ->
            equalizeArray(T, Count);
        true ->
            NewCount = Count + 1,
            NewValue = H - 1,
            equalizeArray([NewValue | T], NewCount)
    end.