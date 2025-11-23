-module(clone_graph).
-export([cloneGraph/1]).

-spec cloneGraph(graphNode()) -> graphNode().
cloneGraph(null) ->
    null;
cloneGraph(Node) ->
    cloneGraph(Node, #{}, []).

cloneGraph(Node, Visited, Queue) ->
    case maps:is_key(Visited, Node) of
        true ->
            maps:get(Node, Visited);
        false ->
            NewNode = #{
                'val' => maps:get(Node, 'val'),
                'neighbors' => []
            },
            NewVisited = maps:put(Node, NewNode, Visited),
            NewQueue = Queue ++ [Node],
            process_queue(NewQueue, NewVisited)
    end.

process_queue([], Visited) ->
    lists:nth(1, maps:values(Visited));
process_queue([Node | Rest], Visited) ->
    NewNode = maps:get(Node, Visited),
    Neighbors = maps:get(Node, 'neighbors'),
    NewNeighbors = [cloneGraph(Neighbor, Visited, []) || Neighbor <- Neighbors],
    NewNewNode = maps:put(NewNode, 'neighbors', NewNeighbors),
    NewVisited = maps:put(Node, NewNewNode, Visited),
    process_queue(Rest, NewVisited).