-module(solution).
-export([longest_special_path/1]).

longest_special_path(Edges) ->
    Graph = build_graph(Edges),
    case detect_cycle(Graph) of
        true -> -1;
        false ->
            MaxLen = lists:foldl(fun(Node, Acc) ->
                max(Acc, dfs(Node, Graph, maps:new()))
            end, 0, maps:keys(Graph)),
            MaxLen
    end.

build_graph(Edges) ->
    lists:foldl(fun([U, V], Acc) ->
        maps:update_with(U, fun(Neighbors) -> [V | Neighbors] end, [V], Acc)
    end, maps:new(), Edges).

detect_cycle(Graph) ->
    Visited = maps:new(),
    RecStack = maps:new(),
    lists:any(fun(Node) ->
        not maps:is_key(Node, Visited) andalso is_cyclic(Node, Graph, Visited, RecStack)
    end, maps:keys(Graph)).

is_cyclic(Node, Graph, Visited, RecStack) ->
    case maps:get(Node, RecStack, false) of
        true -> true;
        false ->
            case maps:get(Node, Visited, false) of
                true -> false;
                false ->
                    NewVisited = maps:put(Node, true, Visited),
                    NewRecStack = maps:put(Node, true, RecStack),
                    lists:any(fun(Neighbor) ->
                        is_cyclic(Neighbor, Graph, NewVisited, NewRecStack)
                    end, maps:get(Node, Graph, [])),
                    maps:put(Node, false, NewRecStack),
                    false
            end
    end.

dfs(Node, Graph, Memo) ->
    case maps:get(Node, Memo, undefined) of
        undefined ->
            MaxLen = case maps:get(Node, Graph, []) of
                [] -> 1;
                Neighbors ->
                    1 + lists:max(lists:map(fun(Neighbor) ->
                        dfs(Neighbor, Graph, Memo)
                    end, Neighbors))
            end,
            maps:put(Node, MaxLen, Memo),
            MaxLen;
        Len -> Len
    end.