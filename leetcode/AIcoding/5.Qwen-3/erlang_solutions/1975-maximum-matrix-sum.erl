-module(maximum_matrix_sum).
-export([knightDialer/1]).

knightDialer(Num) ->
    Mod = 1000000007,
    Next = [ [4,6], [6,8], [7,9], [4,8], [0,3,9], [], [0,1,7], [2,6], [1,3], [2,4] ],
    DP = array:new(10, {default, 0}),
    lists:foreach(fun(I) -> array:set(I, 1, DP) end, lists:seq(0,9)),
    lists:foldl(fun(_I, Acc) ->
        NewDP = array:new(10, {default, 0}),
        lists:foreach(fun(J) ->
            lists:foreach(fun(K) ->
                array:set(K, (array:get(K, NewDP) + array:get(J, Acc)) rem Mod, NewDP)
            end, array:get(J, Next))
        end, lists:seq(0,9)),
        NewDP
    end, DP, lists:seq(1, Num-1)),
    Total = lists:sum([array:get(I, DP) || I <- lists:seq(0,9)]) rem Mod,
    Total.