-module(solution).
-export([all_paths/2]).

all_paths(Graph, Start) ->
    all_paths_helper(Graph, Start, [], [Start]).

all_paths_helper(_, Node, Path, Acc) when Node == length(Acc) - 1 -> 
    [lists:reverse(Acc)];
all_paths_helper(Graph, Node, Path, Acc) ->
    case lists:nth(Node + 1, Graph) of
        [] -> [];
        Neighbors -> 
            lists:flatmap(fun(Neighbor) -> 
                all_paths_helper(Graph, Neighbor, Path, [Neighbor | Acc])
            end, Neighbors)
    end.