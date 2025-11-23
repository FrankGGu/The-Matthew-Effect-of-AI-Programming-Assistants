-module(solution).
-export([min_deletion_size/1]).

min_deletion_size(Strs) ->
    Sorted = lists:sort(Strs),
    MinDel = lists:foldl(fun(Index, Acc) ->
        lists:foldl(fun({Row1, Row2}, Acc1) ->
            if
                lists:nth(Index, Row1) > lists:nth(Index, Row2) -> Acc1 + 1;
                true -> Acc1
            end
        end, Acc, lists:zip(Strs, Sorted))
    end, 0, lists:seq(1, length(hd(Strs)))),

    MinDel.