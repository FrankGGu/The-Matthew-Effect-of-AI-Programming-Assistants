-module(choose_k_elements_with_maximum_sum).
-export([k_items_with_maximum_sum/3]).

k_items_with_maximum_sum(NumOnes, NumZeros, NumNegOnes, K) ->
    if K =< NumOnes ->
        K;
    elseif K =< NumOnes + NumZeros ->
        NumOnes;
    else
        NumOnes - (K - NumOnes - NumZeros)
    end.