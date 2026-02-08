-module(solution).
-export([is_bipartite/1]).

is_bipartite(Graph) ->
    N = length(Graph),
    Colors = lists:duplicate(N, undefined),
    lists:foldl(fun(X, Acc) -> 
        if 
            element(X + 1, Acc) =:= undefined -> 
                Color = 0,
                case dfs(Graph, X, Color, Acc) of
                    {ok, NewAcc} -> NewAcc;
                    {error, _} -> false 
                end;
            true -> Acc 
        end 
    end, Colors, lists:seq(0, N - 1) ) =:= Colors.

dfs(Graph, Node, Color, Colors) ->
    case element(Node + 1, Colors) of
        undefined ->
            NewColors = list_replace(Colors, Node, Color),
            lists:foldl(fun(Neighbor, Acc) ->
                case Acc of
                    false -> false;
                    _ -> 
                        NextColor = (Color + 1) rem 2,
                        dfs(Graph, Neighbor, NextColor, Acc)
                end
            end, NewColors, lists:nth(Node + 1, Graph));
        C when C =:= Color -> 
            {error, conflict}; 
        _ -> 
            {ok, Colors} 
    end.

list_replace(List, Index, Value) ->
    lists:map(fun({I, V}) -> if I =:= Index -> Value; true -> V end end, lists:zip(lists:seq(0, length(List) - 1), List)).