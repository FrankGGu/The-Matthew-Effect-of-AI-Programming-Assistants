-module(solution).
-export([canSplitArray/1]).

canSplitArray(List) ->
    canSplitArray(List, 0).

canSplitArray([], _) ->
    true;
canSplitArray([_], _) ->
    true;
canSplitArray([A, B | Rest], Index) ->
    if
        (A + B) rem 2 == 0 ->
            canSplitArray([B | Rest], Index + 1);
        true ->
            false
    end.