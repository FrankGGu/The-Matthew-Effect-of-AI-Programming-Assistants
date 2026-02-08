-module(count_visited_nodes).
-export([count_visited_nodes/1]).

count_visited_nodes(Edges) ->
    N = length(Edges),
    count_visited_nodes_helper(Edges, N).

count_visited_nodes_helper(Edges, N) ->
    lists:map(fun(Start) -> count_nodes(Start, Edges, N) end, lists:seq(0, N - 1)).

count_nodes(Start, Edges, N) ->
    count_nodes_helper(Start, Edges, N, [], 0).

count_nodes_helper(Node, Edges, N, Visited, Count) ->
    case lists:member(Node, Visited) of
        true ->
            CycleStart = lists:keyfind(Node, 1, lists:reverse(Visited)),
            case CycleStart of
                false ->
                    Count;
                {_, CycleStartIndex} ->
                    Count + length(lists:drop(CycleStartIndex - 1, lists:reverse(Visited)))
            end;
        false ->
            NextNode = lists:nth(Node + 1, Edges),
            count_nodes_helper(NextNode, Edges, N, [Node | Visited], Count + 1)
    end.