-module(non_decreasing_subsequences).
-export([find_subsequences/1]).

find_subsequences(Nums) ->
    find_subsequences(Nums, []).

find_subsequences([], Acc) ->
    lists:usort(Acc);
find_subsequences([H | T], Acc) ->
    NewAcc = lists:foldl(fun(Sub, Acc2) ->
                             case lists:last(Sub) =< H of
                                 true -> [Sub ++ [H] | Acc2];
                                 false -> Acc2
                             end
                         end, Acc, Acc),
    find_subsequences(T, [ [H] | NewAcc ]).

remove_duplicates(List) ->
    lists:usort(List).