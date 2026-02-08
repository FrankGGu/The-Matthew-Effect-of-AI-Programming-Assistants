-module(solution).
-export([num_nice_pairs/1]).

num_nice_pairs(Nums) ->
    Count = maps:from_list([{X, 0} || X <- NumList]),
    lists:foldl(fun(N, Acc) -> 
        Diff = N - reverse_number(N),
        maps:update(Diff, maps:get(Diff, Acc) + 1, Acc)
    end, Count, NumList),
    maps:fold(fun(_, V, Acc) -> Acc + (V * (V - 1)) div 2 end, 0, Count).

reverse_number(N) ->
    reverse_number(N, 0).

reverse_number(0, Acc) ->
    Acc;
reverse_number(N, Acc) ->
    reverse_number(N div 10, Acc * 10 + N rem 10).