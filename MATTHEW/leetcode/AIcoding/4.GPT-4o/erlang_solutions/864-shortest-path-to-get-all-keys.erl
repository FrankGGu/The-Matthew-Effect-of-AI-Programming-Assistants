-module(solution).
-export([shortest_path_to_get_all_keys/1]).

shortest_path_to_get_all_keys(Grid) ->
    start_pos = find_start_pos(Grid, 0, 0),
    Keys = find_keys(Grid, []),
    num_keys = length(Keys),
    bfs([{start_pos, 0, 0}], Grid, num_keys).

find_start_pos([], _, _) -> {0, 0};
find_start_pos([Row | Rest], X, Y) ->
    case lists:find(fun(C) -> C =:= $@ end, Row) of
        none -> find_start_pos(Rest, X, Y + 1);
        _ -> {X, Y}
    end.

find_keys(Grid, Acc) ->
    case lists:foldl(fun(Row, Acc) -> 
                        lists:foldl(fun(C, Acc) -> 
                                        case C of
                                            $a -> [{X, Y} | Acc];
                                            _ -> Acc
                                        end
                                    end, Acc, Row)
                    end, Acc, Grid) of
        [] -> Acc;
        NewKeys -> lists:usort(NewKeys)
    end.

bfs(Queue, Grid, NumKeys) ->
    case Queue of
        [] -> -1;
        [{Pos, KeysCollected, Steps} | Rest] ->
            if
                KeysCollected == (1 bsl NumKeys) - 1 -> Steps;
                true ->
                    NewQueue = lists:foldl(fun(NewPos, Acc) -> 
                                                case is_valid_move(NewPos, Grid, KeysCollected) of
                                                    true -> [{NewPos, NewKeysCollected, Steps + 1} | Acc];
                                                    false -> Acc
                                                end
                                            end, Rest, get_neighbors(Pos)),
                    bfs(NewQueue, Grid, NumKeys)
            end
    end.

is_valid_move({X, Y}, Grid, KeysCollected) ->
    case lists:nth(Y + 1, Grid) of
        Row when Y >= 0, Y < length(Grid) ->
            case lists:nth(X + 1, Row) of
                $# -> false;
                Key when Key >= $a, Key =< $z -> (KeysCollected band (1 bsl (Key - $a))) =:= 0;
                _ -> true
            end;
        _ -> false
    end.

get_neighbors({X, Y}) -> [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}].