-module(solution).
-export([numberOfWaysToArrangePeople/1]).

numberOfWaysToArrangePeople(Num) ->
    Ways = 0,
    Rows = lists:seq(1, Num),
    Columns = lists:seq(1, Num),
    Count = 0,
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Column, Acc2) ->
            if
                Row /= Column ->
                    Count2 = Acc2 + 1,
                    Count2;
                true ->
                    Acc2
            end
        end, Acc, Columns)
    end, 0, Rows).