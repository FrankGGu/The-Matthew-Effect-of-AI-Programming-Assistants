-module(maximum_strong_pair_xor_i).
-export([maximum_strong_pair_xor_i/1]).

maximum_strong_pair_xor_i(Nums) ->
    maximum_strong_pair_xor_i(Nums, 0).

maximum_strong_pair_xor_i([], MaxXor) ->
    MaxXor;
maximum_strong_pair_xor_i([H|T], MaxXor) ->
    maximum_strong_pair_xor_i(T, maximum_strong_pair_xor_i_helper([H|T], H, MaxXor)).

maximum_strong_pair_xor_i_helper([], _, MaxXor) ->
    MaxXor;
maximum_strong_pair_xor_i_helper([H|T], Num1, MaxXor) ->
    NewMaxXor = lists:foldl(fun(Num2, AccMaxXor) ->
                                    if abs(Num1 - Num2) =< min(Num1, Num2) ->
                                        max(AccMaxXor, Num1 bxor Num2)
                                    else
                                        AccMaxXor
                                    end
                                end, MaxXor, [H|T]),
    NewMaxXor.