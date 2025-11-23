-module(solution).
-export([min_time_to_collect_apples/3]).

min_time_to_collect_apples(Tree, HasApple, Start) ->
    TotalTime = dfs(Tree, HasApple, Start, []),
    TotalTime.

dfs([], _, _, _) -> 0;
dfs([{Node, Children} | Rest], HasApple, Start, Visited) ->
    if
        lists:member(Node, Visited) -> 
            dfs(Rest, HasApple, Start, Visited);
        HasApple[Node] =:= true orelse lists:foldl(fun(C, Acc) -> Acc orelse HasApple[C] end, false, Children) ->
            PathTime = 2 * (node_distance(Start, Node)),
            PathTime + dfs(Rest, HasApple, Node, [Node | Visited]);
        true -> 
            dfs(Rest, HasApple, Start, Visited)
    end.

node_distance(Start, Node) ->
    case Start of
        Node -> 0;
        _ -> 1
    end.