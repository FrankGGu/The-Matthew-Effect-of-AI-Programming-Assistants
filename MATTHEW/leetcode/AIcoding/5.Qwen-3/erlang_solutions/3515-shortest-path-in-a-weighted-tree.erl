-module(shortest_path_in_a_weighted_tree).
-export([min_cost/1]).

min_cost(Tree) ->
    min_cost(Tree, 0, []).

min_cost([], _Depth, Path) ->
    lists:reverse(Path);
min_cost([{Value, Children} | _Rest], Depth, Path) ->
    NewPath = [Value | Path],
    case Children of
        [] ->
            NewPath;
        _ ->
            lists:min([min_cost(Child, Depth + 1, NewPath) || Child <- Children])
    end.