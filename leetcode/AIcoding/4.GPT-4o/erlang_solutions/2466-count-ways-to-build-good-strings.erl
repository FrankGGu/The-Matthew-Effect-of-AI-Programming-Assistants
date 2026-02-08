-module(solution).
-export([countGoodStrings/4]).

countGoodStrings(N, min, max, target) ->
    Mod = 1000000007,
    countGoodStrings_helper(N, min, max, target, 0, Mod, []).

countGoodStrings_helper(N, Min, Max, Target, Current, Mod, Memo) ->
    if
        Current > Target -> 0;
        Current =:= Target -> 1;
        Current < Target -> 
            case lists:keyfind(Current, 1, Memo) of
                {_, Result} -> Result;
                false ->
                    Ways = lists:sum(
                        [countGoodStrings_helper(N, Min, Max, Target, Current + X, Mod, Memo)
                         || X <- lists:seq(Min, Max)]),
                    Result = (Ways rem Mod),
                    Memo1 = [{Current, Result} | Memo],
                    Result
            end
    end.