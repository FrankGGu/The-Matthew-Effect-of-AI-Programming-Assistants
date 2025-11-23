-module(duplicate_zeros).
-export([duplicate_zeros/1]).

duplicate_zeros(Arr) ->
    duplicate_zeros_helper(Arr, 0, length(Arr)).

duplicate_zeros_helper(Arr, Index, Len) ->
    if Index >= Len then
        Arr
    else
        case lists:nth(Index + 1, Arr) of
            0 ->
                NewArr = lists:sublist(Arr, 1, Index + 1) ++ [0] ++ lists:sublist(Arr, Index + 2, Len - Index - 1),
                duplicate_zeros_helper(NewArr, Index + 2, Len);
            _ ->
                duplicate_zeros_helper(Arr, Index + 1, Len)
        end.