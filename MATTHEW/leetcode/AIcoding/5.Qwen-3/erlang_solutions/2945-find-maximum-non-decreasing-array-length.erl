-module(max_non_decreasing_length).
-export([length_of_lis/1]).

length_of_lis(Nums) ->
    length_of_lis(Nums, []).

length_of_lis([], _LIS) ->
    length(_LIS);
length_of_lis([H | T], LIS) ->
    case LIS of
        [] ->
            length_of_lis(T, [H]);
        _ ->
            case H >= lists:last(LIS) of
                true ->
                    length_of_lis(T, LIS ++ [H]);
                false ->
                    length_of_lis(T, LIS)
            end
    end.