-module(bipartite).
-export([is_bipartite/1]).

is_bipartite(Graph) ->
    Map = maps:new(),
    lists:foreach(fun(Node) -> 
        case maps:find(Node, Map) of
            {ok, _} -> ok;
            error -> 
                case dfs(Node, Map, 0) of
                    {ok, NewMap} -> 
                        ok;
                    {error, _} -> 
                        false
                end
        end
    end, graphs:all_nodes(Graph)),
    true.

graphs:all_nodes(Graph) ->
    lists:usort(lists:flatten(Graph)).

dfs(Node, Map, Color) ->
    case maps:find(Node, Map) of
        {ok, C} when C == Color -> {ok, Map};
        {ok, C} -> {error, {Node, C, Color}};
        error ->
            NewMap = maps:put(Node, Color, Map),
            lists:foreach(fun(Adj) ->
                case dfs(Adj, NewMap, 1 - Color) of
                    {ok, _} -> ok;
                    {error, _} -> throw({error, Node})
                end
            end, lists:keysort(1, Graph -- [Node])),
            {ok, NewMap}
    end.