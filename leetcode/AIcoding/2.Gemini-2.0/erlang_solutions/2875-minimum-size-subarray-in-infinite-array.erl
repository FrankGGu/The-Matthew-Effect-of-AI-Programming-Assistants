-module(min_size_subarray_infinite).
-export([min_size_subarray/2]).

min_size_subarray(Nums, Target) ->
    Len = length(Nums),
    Sum = lists:sum(Nums),
    if Sum == 0 ->
        if Target == 0 ->
            1;
        true ->
            -1
        end;
    true ->
        Div = Target div Sum,
        Rem = Target rem Sum,
        if Rem == 0 ->
            Div * Len;
        true ->
            find_min_len(Nums, Rem, Len) + Div * Len
        end
    end.

find_min_len(Nums, Target, Len) ->
    find_min_len_helper(Nums ++ Nums, Target, Len, 0, 0, infinity).

find_min_len_helper(_Nums, _Target, _Len, _L, _Sum, MinLen) when MinLen == 1 ->
    MinLen;
find_min_len_helper(Nums, Target, Len, L, Sum, MinLen) ->
    case Nums of
        [] ->
            MinLen;
        [H|T] ->
            NewSum = Sum + H,
            case NewSum >= Target of
                true ->
                    R = L;
                    ResLen = R + 1 - 0;
                    NewMinLen = min(MinLen,ResLen);

                    find_min_len_helper(T, Target, Len, L, NewSum - lists:nth(0,Nums), min(NewMinLen,ResLen));

                false ->
                    find_min_len_helper(T, Target, Len, L+1, NewSum, MinLen)
            end
    end.