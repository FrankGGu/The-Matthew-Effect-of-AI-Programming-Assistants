-module(longest_cycle_in_a_graph).
-export([longest_cycle/1]).

longest_cycle(Edges) ->
    N = length(Edges),
    Graph = build_graph(N, Edges),
    Visited = array:new(N, {default, false}),
    InStack = array:new(N, {default, false}),
    MaxCycleLength = -1,
    dfs(0, Graph, Visited, InStack, 0, MaxCycleLength).

build_graph(N, Edges) ->
    Graph = array:new(N, {default, []}),
    build_graph(Edges, Graph).

build_graph([], Graph) ->
    Graph;
build_graph([{From, To} | Rest], Graph) ->
    NewGraph = array:set(From, [To | array:get(From, Graph)], Graph),
    build_graph(Rest, NewGraph).

dfs(Node, Graph, Visited, InStack, Depth, MaxCycleLength) ->
    case array:get(Node, Visited) of
        true ->
            case array:get(Node, InStack) of
                true ->
                    max(Depth, MaxCycleLength);
                false ->
                    MaxCycleLength
            end;
        false ->
            NewVisited = array:set(Node, true, Visited),
            NewInStack = array:set(Node, true, InStack),
            Children = array:get(Node, Graph),
            lists:foldl(
                fun(Child, Acc) ->
                    dfs(Child, Graph, NewVisited, NewInStack, Depth + 1, Acc)
                end,
                MaxCycleLength,
                Children
            )
    end.

dfs(_, _, _, _, _, MaxCycleLength) ->
    MaxCycleLength.