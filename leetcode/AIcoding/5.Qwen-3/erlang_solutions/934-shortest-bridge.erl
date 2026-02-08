-module(shortest_bridge).
-export([shortest_bridge/1]).

shortest_bridge(Grid) ->
    N = length(Grid),
    {X, Y} = find_first_one(Grid),
    mark_island(Grid, X, Y, 2),
    Queue = queue:from_list([{X, Y, 0}]),
    bfs(Grid, Queue, N).

find_first_one(Grid) ->
    find_first_one(Grid, 0, 0).

find_first_one([], _, _) ->
    {0, 0};
find_first_one([Row | Rest], I, J) ->
    case lists:keymember(1, 1, Row) of
        true ->
            J1 = lists:foldl(fun(Elem, Acc) -> if Elem == 1 -> Acc; true -> Acc + 1 end end, 0, Row),
            {I, J1};
        false ->
            find_first_one(Rest, I + 1, 0)
    end.

mark_island(Grid, X, Y, Val) ->
    case Grid of
        [] -> ok;
        [Row | Rest] ->
            case X of
                0 ->
                    case Y of
                        0 ->
                            case lists:nth(1, Row) of
                                1 ->
                                    NewRow = lists:sublist(Row, 1, 1) ++ [Val | lists:nthtail(2, Row)],
                                    mark_island([NewRow | Rest], 0, 1, Val);
                                _ ->
                                    mark_island(Rest, 1, 0, Val)
                            end;
                        _ ->
                            case lists:nth(Y + 1, Row) of
                                1 ->
                                    NewRow = lists:sublist(Row, Y + 1, 1) ++ [Val | lists:nthtail(Y + 2, Row)],
                                    mark_island([NewRow | Rest], X, Y + 1, Val);
                                _ ->
                                    mark_island(Rest, X + 1, 0, Val)
                            end
                    end;
                _ ->
                    case Y of
                        0 ->
                            case lists:nth(1, Row) of
                                1 ->
                                    NewRow = lists:sublist(Row, 1, 1) ++ [Val | lists:nthtail(2, Row)],
                                    mark_island([NewRow | Rest], X, 1, Val);
                                _ ->
                                    mark_island(Rest, X + 1, 0, Val)
                            end;
                        _ ->
                            case lists:nth(Y + 1, Row) of
                                1 ->
                                    NewRow = lists:sublist(Row, Y + 1, 1) ++ [Val | lists:nthtail(Y + 2, Row)],
                                    mark_island([NewRow | Rest], X, Y + 1, Val);
                                _ ->
                                    mark_island(Rest, X + 1, 0, Val)
                            end
                    end
            end
    end.

bfs(Grid, Queue, N) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {X, Y, D}}, Q} ->
            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            lists:foreach(fun({DX, DY}) ->
                NX = X + DX,
                NY = Y + DY,
                case is_valid(NX, NY, N) of
                    true ->
                        case get_value(Grid, NX, NY) of
                            0 ->
                                set_value(Grid, NX, NY, 2),
                                queue:in({NX, NY, D + 1}, Q);
                            1 ->
                                D;
                            _ ->
                                ok
                        end;
                    false ->
                        ok
                end
            end, Directions),
            bfs(Grid, Q, N)
    end.

is_valid(X, Y, N) ->
    X >= 0 andalso X < N andalso Y >= 0 andalso Y < N.

get_value(Grid, X, Y) ->
    Row = lists:nth(X + 1, Grid),
    lists:nth(Y + 1, Row).

set_value(Grid, X, Y, Val) ->
    Row = lists:nth(X + 1, Grid),
    NewRow = lists:sublist(Row, Y + 1, 1) ++ [Val | lists:nthtail(Y + 2, Row)],
    lists:substitute_at(Grid, X + 1, NewRow).