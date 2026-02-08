-module(solution).
-export([length_of_lis/1]).

length_of_lis(Nums) ->
    length_of_lis(Nums, #{}).

length_of_lis([], _) ->
    0;
length_of_lis([H | T], Acc) ->
    Max = maps:fold(fun(Key, Val, Acc2) when Key < H ->
                           if Val + 1 > Acc2 -> Val + 1;
                              true -> Acc2
                           end;
                      (_, _, Acc2) ->
                           Acc2
                   end, 0, Acc),
    NewAcc = maps:put(H, Max, Acc),
    max(Max, length_of_lis(T, NewAcc)).