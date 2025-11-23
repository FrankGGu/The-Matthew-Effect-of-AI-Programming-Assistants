-module(solution).
-export([minimum_operations/1]).

minimum_operations(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    DP = lists:duplicate(10, 0),
    lists:foldl(fun(Col, AccDP) ->
        Counts = lists:foldl(fun(Row, Acc) ->
            Val = lists:nth(Col, lists:nth(Row, Matrix)),
            maps:update_with(Val, fun(V) -> V + 1 end, 1, Acc)
        end, #{}, lists:seq(1, Rows)),
        NewDP = lists:map(fun(PrevVal) ->
            lists:min(lists:map(fun(NewVal) ->
                case NewVal of
                    PrevVal -> 999999999;
                    _ -> maps:get(NewVal, Counts, 0) + element(NewVal + 1, AccDP)
                end
            end, lists:seq(0, 9)))
        end, lists:seq(0, 9)),
        list_to_tuple(NewDP)
    end, DP, lists:seq(1, Cols)),
    lists:min(tuple_to_list(DP)).