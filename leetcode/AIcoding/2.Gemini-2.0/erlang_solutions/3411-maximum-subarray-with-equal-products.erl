-module(maximum_subarray_with_equal_products).
-export([max_equal_products_subarray/1]).

max_equal_products_subarray(Nums) ->
    max_equal_products_subarray(Nums, 1, 0, 0, 0).

max_equal_products_subarray([], _, MaxLen, _, _) ->
    MaxLen;
max_equal_products_subarray([H|T], Prod, CurrentLen, MaxLen, ZeroCount) ->
    case H of
        0 ->
            NewZeroCount = ZeroCount + 1,
            NewCurrentLen = CurrentLen + 1,
            NewMaxLen = max(MaxLen, NewCurrentLen),
            max_equal_products_subarray(T, 0, NewCurrentLen, NewMaxLen, NewZeroCount);
        _ ->
            NewProd = Prod * H,
            case NewProd of
                0 ->
                    NewZeroCount = ZeroCount + 1,
                    NewCurrentLen = CurrentLen + 1,
                    NewMaxLen = max(MaxLen, NewCurrentLen),
                    max_equal_products_subarray(T, 0, NewCurrentLen, NewMaxLen, NewZeroCount);
                _ ->
                    NewCurrentLen = CurrentLen + 1,
                    NewMaxLen = max(MaxLen, NewCurrentLen),
                    max_equal_products_subarray(T, NewProd, NewCurrentLen, NewMaxLen, ZeroCount)
            end
    end.

max(A, B) ->
    if A > B -> A; true -> B end.