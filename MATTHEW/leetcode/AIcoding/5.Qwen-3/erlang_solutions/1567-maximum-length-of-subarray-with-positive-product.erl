-module(max_length_of_subarray_with_positive_product).
-export([max_len/1]).

max_len(Nums) ->
    max_len(Nums, 0, 0, 0, 0).

max_len([], _, _, _, _) ->
    0;
max_len([0 | Rest], _, _, _, _) ->
    max_len(Rest, 0, 0, 0, 0);
max_len([X | Rest], Count, Pos, Neg, Max) ->
    if
        X == 0 ->
            max_len(Rest, 0, 0, 0, max(Max, Count));
        X > 0 ->
            NewCount = Count + 1,
            NewPos = Pos + 1,
            NewNeg = Neg,
            max_len(Rest, NewCount, NewPos, NewNeg, max(Max, NewCount));
        true ->
            NewCount = Count + 1,
            NewPos = Pos,
            NewNeg = Neg + 1,
            max_len(Rest, NewCount, NewPos, NewNeg, max(Max, NewCount))
    end.