-module(longest_special_path_ii).
-export([longestPath/2]).

longestPath(Edges, Node) ->
    Graph = buildGraph(Edges),
    {MaxLen, _} = dfs(Node, Graph, 0, dict:new()),
    MaxLen.

buildGraph(Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc1 = dict:update_counter(A, 1, Acc),
        Acc2 = dict:update_counter(B, 1, Acc1),
        Acc2
    end, dict:new(), Edges).

dfs(Node, Graph, Len, Visited) ->
    case dict:is_key(Node, Visited) of
        true -> {Len, false};
        false ->
            Visited1 = dict:store(Node, true, Visited),
            Children = dict:fetch(Node, Graph, []),
            lists:foldl(fun(Child, {MaxLen, HasCycle}) ->
                {ChildLen, ChildHasCycle} = dfs(Child, Graph, Len + 1, Visited1),
                {max(MaxLen, ChildLen), HasCycle or ChildHasCycle}
            end, {Len, false}, Children)
    end.