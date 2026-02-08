-module(longest_subarray_and).
-export([find_length/1]).

find_length(Nums) ->
    find_length(Nums, 0, 0, 0).

find_length([], _, MaxVal, Len) ->
    Len;
find_length([H|T], CurrLen, MaxVal, Len) ->
    case H > MaxVal of
        true ->
            find_length(T, 1, H, 1);
        false ->
            case H =:= MaxVal of
                true ->
                    find_length(T, CurrLen + 1, MaxVal, max(Len, CurrLen + 1));
                false ->
                    find_length(T, 0, MaxVal, Len)
            end
    end.