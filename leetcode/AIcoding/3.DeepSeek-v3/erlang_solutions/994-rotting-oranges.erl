-module(rotting_oranges).
-export([orangesRotting/1]).

orangesRotting(Grid) ->
    {M, N} = {length(Grid), length(hd(Grid))},
    Queue = queue:new(),
    Fresh = lists:foldl(fun(I, Acc1) ->
        lists:foldl(fun(J, Acc2) ->
            case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
                2 -> queue:in({I, J, 0}, Acc2);
                1 -> Acc2 + 1;
                _ -> Acc2
            end
        end, Acc1, lists:seq(0, N - 1))
    end, 0, lists:seq(0, M - 1)),
    orangesRotting(Queue, Fresh, M, N, 0).

orangesRotting(Queue, Fresh, M, N, Minutes) ->
    case queue:is_empty(Queue) of
        true ->
            case Fresh of
                0 -> Minutes;
                _ -> -1
            end;
        false ->
            {{value, {I, J, Time}}, NewQueue} = queue:out(Queue),
            NewMinutes = max(Minutes, Time),
            Adjacent = [{I + 1, J}, {I - 1, J}, {I, J + 1}, {I, J - 1}],
            {UpdatedQueue, UpdatedFresh} = lists:foldl(fun({X, Y}, {Q, F}) ->
                case X >= 0 andalso X < M andalso Y >= 0 andalso Y < N andalso
                     lists:nth(Y + 1, lists:nth(X + 1, rotting_oranges:get_grid())) == 1 of
                    true ->
                        NewQ = queue:in({X, Y, Time + 1}, Q),
                        rotting_oranges:set_grid(X, Y, 2),
                        {NewQ, F - 1};
                    false ->
                        {Q, F}
                end
            end, {NewQueue, Fresh}, Adjacent),
            orangesRotting(UpdatedQueue, UpdatedFresh, M, N, NewMinutes)
    end.

get_grid() ->
    case get(grid) of
        undefined -> [];
        Grid -> Grid
    end.

set_grid(X, Y, Value) ->
    Grid = get_grid(),
    Row = lists:nth(X + 1, Grid),
    NewRow = lists:sublist(Row, Y) ++ [Value] ++ lists:nthtail(Y + 1, Row),
    NewGrid = lists:sublist(Grid, X) ++ [NewRow] ++ lists:nthtail(X + 1, Grid),
    put(grid, NewGrid).