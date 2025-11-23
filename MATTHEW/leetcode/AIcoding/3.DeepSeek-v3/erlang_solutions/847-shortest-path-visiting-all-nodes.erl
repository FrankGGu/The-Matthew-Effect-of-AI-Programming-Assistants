-module(solution).
-export([shortest_path_length/1]).

shortest_path_length(Graph) ->
    N = length(Graph),
    TargetMask = (1 bsl N) - 1,
    Queue = queue:new(),
    Visited = sets:new(),

    lists:foreach(fun(Node) ->
        InitialMask = 1 bsl Node,
        queue:in({Node, InitialMask}, Queue),
        sets:add_element({Node, InitialMask}, Visited)
    end, lists:seq(0, N - 1)),

    shortest_path_length(Queue, Visited, Graph, TargetMask, 0).

shortest_path_length(Queue, Visited, Graph, TargetMask, Steps) ->
    case queue:is_empty(Queue) of
        true -> -1;
        false ->
            {{value, {Node, Mask}}, NewQueue} = queue:out(Queue),
            case Mask =:= TargetMask of
                true -> Steps;
                false ->
                    Neighbors = lists:nth(Node + 1, Graph),
                    UpdatedQueue = lists:foldl(fun(Neighbor, AccQueue) ->
                        NewMask = Mask bor (1 bsl Neighbor),
                        case sets:is_element({Neighbor, NewMask}, Visited) of
                            true -> AccQueue;
                            false ->
                                NewVisited = sets:add_element({Neighbor, NewMask}, Visited),
                                queue:in({Neighbor, NewMask}, AccQueue),
                                {NewVisited, NewQueue} = {NewVisited, AccQueue},
                                NewQueue
                        end
                    end, NewQueue, Neighbors),
                    shortest_path_length(UpdatedQueue, Visited, Graph, TargetMask, Steps + 1)
            end
    end.