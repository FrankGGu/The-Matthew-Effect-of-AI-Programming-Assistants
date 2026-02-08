-module(solution).
-export([maximum_strong_pair_xor_i/1]).

maximum_strong_pair_xor_i(Nums) ->
    lists:foldl(fun(NumI, AccMaxXor) ->
        lists:foldl(fun(NumJ, InnerAccMaxXor) ->
            MinVal = min(NumI, NumJ),
            MaxVal = max(NumI, NumJ),
            if
                MaxVal =< 2 * MinVal ->
                    max(InnerAccMaxXor, NumI bxor NumJ);
                true ->
                    InnerAccMaxXor
            end
        end, AccMaxXor, Nums)
    end, 0, Nums).