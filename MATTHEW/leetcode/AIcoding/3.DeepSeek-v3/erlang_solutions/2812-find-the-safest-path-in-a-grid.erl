-module(solution).
-export([maximum_safeness_factor/1]).

maximum_safeness_factor(Grid) ->
    N = length(Grid),
    case N of
        0 -> 0;
        _ ->
            M = length(hd(Grid)),
            Thieves = find_thieves(Grid, N, M),
            Dist = compute_distances(Grid, N, M, Thieves),
            MaxDist = find_max_distance(Dist, N, M),
            binary_search(Dist, N, M, MaxDist)
    end.

find_thieves(Grid, N, M) ->
    lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            case lists:nth(J, lists:nth(I, Grid)) of
                1 -> [{I-1, J-1} | AccJ];
                _ -> AccJ
            end
        end, AccI, lists:seq(1, M))
    end, [], lists:seq(1, N)).

compute_distances(Grid, N, M, Thieves) ->
    Dist = [ [ -1 || _ <- lists:seq(1, M) ] || _ <- lists:seq(1, N) ],
    Queue = queue:from_list([ {X, Y, 0} || {X, Y} <- Thieves ]),
    UpdatedDist = lists:foldl(fun({X, Y}, D) ->
        set_distance(D, X, Y, 0)
    end, Dist, Thieves),
    bfs(Queue, UpdatedDist, N, M).

set_distance(Dist, X, Y, Val) ->
    Row = lists:nth(X+1, Dist),
    NewRow = set_element(Y+1, Row, Val),
    set_element(X+1, Dist, NewRow).

set_element(1, [_|T], Val) -> [Val|T];
set_element(N, [H|T], Val) -> [H|set_element(N-1, T, Val)].

bfs(Queue, Dist, N, M) ->
    case queue:is_empty(Queue) of
        true -> Dist;
        false ->
            {{value, {X, Y, D}}, NewQueue} = queue:out(Queue),
            Neighbors = [{X+1, Y}, {X-1, Y}, {X, Y+1}, {X, Y-1}],
            {UpdatedDist, UpdatedQueue} = lists:foldl(fun({NX, NY}, {Dst, Q}) ->
                case (NX >= 0) and (NX < N) and (NY >= 0) and (NY < M) of
                    true ->
                        CurrentDist = lists:nth(NY+1, lists:nth(NX+1, Dst)),
                        case CurrentDist =:= -1 orelse (D + 1 < CurrentDist) of
                            true ->
                                NewDst = set_distance(Dst, NX, NY, D + 1),
                                NewQ = queue:in({NX, NY, D + 1}, Q),
                                {NewDst, NewQ};
                            false -> {Dst, Q}
                        end;
                    false -> {Dst, Q}
                end
            end, {Dist, NewQueue}, Neighbors),
            bfs(UpdatedQueue, UpdatedDist, N, M)
    end.

find_max_distance(Dist, N, M) ->
    lists:foldl(fun(I, MaxI) ->
        lists:foldl(fun(J, MaxJ) ->
            max(lists:nth(J, lists:nth(I, Dist)), MaxJ)
        end, MaxI, lists:seq(1, M))
    end, 0, lists:seq(1, N)).

binary_search(Dist, N, M, MaxDist) ->
    binary_search(Dist, N, M, 0, MaxDist).

binary_search(Dist, N, M, Low, High) ->
    if
        Low > High -> Low - 1;
        true ->
            Mid = (Low + High) div 2,
            case can_reach(Dist, N, M, Mid) of
                true -> binary_search(Dist, N, M, Mid + 1, High);
                false -> binary_search(Dist, N, M, Low, Mid - 1)
            end
    end.

can_reach(Dist, N, M, K) ->
    Visited = [ [ false || _ <- lists:seq(1, M) ] || _ <- lists:seq(1, N) ],
    case lists:nth(1, lists:nth(1, Dist)) >= K of
        false -> false;
        true -> dfs(Dist, N, M, 0, 0, K, Visited)
    end.

dfs(Dist, N, M, X, Y, K, Visited) ->
    if
        X =:= N - 1 andalso Y =:= M - 1 -> true;
        true ->
            NewVisited = set_element(X+1, Visited, set_element(Y+1, lists:nth(X+1, Visited), true)),
            Neighbors = [{X+1, Y}, {X-1, Y}, {X, Y+1}, {X, Y-1}],
            lists:any(fun({NX, NY}) ->
                case (NX >= 0) and (NX < N) and (NY >= 0) and (NY < M) of
                    true ->
                        case not lists:nth(NY+1, lists:nth(NX+1, NewVisited)) andalso
                             lists:nth(NY+1, lists:nth(NX+1, Dist)) >= K of
                            true -> dfs(Dist, N, M, NX, NY, K, NewVisited);
                            false -> false
                        end;
                    false -> false
                end
            end, Neighbors)
    end.