-module(solution).
-export([find_lonely_numbers/1]).

find_lonely_numbers(Nums) ->
    NumsSet = maps:from_list([{Num, true} || Num <- Nums]),
    lists:filter(fun(Num) -> not maps:is_key(Num + 1, NumsSet) andalso not maps:is_key(Num - 1, NumsSet) end, Nums).