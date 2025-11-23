-module(solution).
-export([count_pairs/1]).

count_pairs(Nums) ->
    Count = maps:from_list([{N, 0} || N <- NumList]),
    Total = 0,
    lists:foreach(fun(N) -> 
        maps:put(N, maps:get(N, Count) + 1, Count)
    end, NumList),
    MaxPower = 20,
    lists:foldl(fun(N, Acc) ->
        lists:foldl(fun(Power, A) ->
            Target = (1 bsl Power) - N,
            case maps:is_key(Target, Count) of
                true -> A + maps:get(Target, Count);
                false -> A
            end
        end, Acc, lists:seq(0, MaxPower))
    end, 0, NumList).

-define(MAX_POWER, 20).