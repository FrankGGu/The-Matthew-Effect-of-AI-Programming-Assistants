-module(solution).
-export([get_maximum_xor/2]).

get_maximum_xor(Nums, MaximumBit) ->
    MaxVal = (1 bsl MaximumBit) - 1,
    calculate_k_list(Nums, MaxVal, 0, []).

calculate_k_list([], _MaxVal, _CurrentXorSum, AccResults) ->
    lists:reverse(AccResults);
calculate_k_list([H|T], MaxVal, CurrentXorSum, AccResults) ->
    NewXorSum = CurrentXorSum bxor H,
    K = NewXorSum bxor MaxVal,
    calculate_k_list(T, MaxVal, NewXorSum, [K|AccResults]).