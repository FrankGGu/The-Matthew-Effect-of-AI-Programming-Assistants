-module(split_array).
-export([split_array_largest_sum/2]).

split_array_largest_sum(Nums, K) ->
    binary_search(Nums, K, lists:sum(Nums), lists:max(Nums)).

binary_search(Nums, K, High, Low) ->
    case Low =:= High of
        true ->
            Low;
        false ->
            Mid = (Low + High) div 2,
            case is_valid(Nums, K, Mid) of
                true ->
                    binary_search(Nums, K, Mid, Low);
                false ->
                    binary_search(Nums, K, High, Mid + 1)
            end
    end.

is_valid(Nums, K, MaxSum) ->
    is_valid(Nums, K, MaxSum, 0, 1).

is_valid([], _K, _MaxSum, _CurrentSum, _Count) ->
    true;
is_valid([H|T], K, MaxSum, CurrentSum, Count) ->
    case CurrentSum + H =< MaxSum of
        true ->
            is_valid(T, K, MaxSum, CurrentSum + H, Count);
        false ->
            case Count + 1 =< K of
                true ->
                    is_valid(T, K, MaxSum, H, Count + 1);
                false ->
                    false
            end
    end.