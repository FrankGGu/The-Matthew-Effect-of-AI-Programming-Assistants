-module(solution).
-export([count_subtrees/1]).

count_subtrees(N, Edges) ->
    Adj = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
                          maps:update_with(V, fun(L) -> [U | L] end, [U], Acc)
                      end, #{}, Edges),
    lists:foldl(fun(Mask, Acc) ->
                    case is_valid_subtree(N, Mask, Adj) of
                        {true, D} -> maps:update_with(D, fun(C) -> C + 1 end, 1, Acc);
                        false -> Acc
                    end
                end, #{}, lists:seq(1, (1 bsl N) - 1)).

is_valid_subtree(N, Mask, Adj) ->
    Nodes = [I || I <- lists:seq(1, N), (Mask band (1 bsl (I - 1))) =/= 0],
    case Nodes of
        [] -> false;
        _ ->
            case is_connected(Nodes, Adj) of
                true -> {true, max_distance(Nodes, Adj)};
                false -> false
            end
    end.

is_connected(Nodes, Adj) ->
    Visited = sets:new(),
    Queue = queue:from_list([hd(Nodes)]),
    BFS(Nodes, Adj, Visited, Queue).

BFS(Nodes, Adj, Visited, Queue) ->
    case queue:is_empty(Queue) of
        true -> sets:size(Visited) =:= length(Nodes);
        false ->
            {{value, U}, Q} = queue:out(Queue),
            case sets:is_element(U, Visited) of
                true -> BFS(Nodes, Adj, Visited, Q);
                false ->
                    NewVisited = sets:add_element(U, Visited),
                    Neighbors = maps:get(U, Adj, []),
                    NewQueue = lists:foldl(fun(V, QAcc) ->
                                              case lists:member(V, Nodes) of
                                                  true -> queue:in(V, QAcc);
                                                  false -> QAcc
                                              end
                                          end, Q, Neighbors),
                    BFS(Nodes, Adj, NewVisited, NewQueue)
            end
    end.

max_distance(Nodes, Adj) ->
    lists:max([diameter([U], Adj, sets:new()) || U <- Nodes]).

diameter([], _, _) -> 0;
diameter(Queue, Adj, Visited) ->
    case queue:is_empty(Queue) of
        true -> 0;
        false ->
            {{value, U}, Q} = queue:out(Queue),
            case sets:is_element(U, Visited) of
                true -> diameter(Q, Adj, Visited);
                false ->
                    NewVisited = sets:add_element(U, Visited),
                    Neighbors = maps:get(U, Adj, []),
                    NewQueue = lists:foldl(fun(V, QAcc) -> queue:in(V, QAcc) end, Q, Neighbors),
                    1 + diameter(NewQueue, Adj, NewVisited)
            end
    end.

count_subtrees(Edges) ->
    N = length(lists:usort(lists:append(Edges))),
    Result = count_subtrees(N, Edges),
    lists:map(fun(D) -> maps:get(D, Result, 0) end, lists:seq(1, N - 1)).