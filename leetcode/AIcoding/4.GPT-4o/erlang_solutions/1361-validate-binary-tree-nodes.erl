-module(solution).
-export([validate_binary_tree_nodes/3]).

validate_binary_tree_nodes(N, Left, Right) ->
    validate(N, Left, Right, 0, []).

validate(N, Left, Right, Count, Visited) when Count < N ->
    case lists:nth(Count + 1, Visited) of
        undefined ->
            case lists:nth(Count + 1, Left) of
                -1 -> validate(N, Left, Right, Count + 1, [Count | Visited]);
                _ -> validate_tree(N, Left, Right, Count, Visited)
            end;
        _ -> false
    end;
validate(_, _, _, Count, _) when Count =:= 0 -> true;
validate(_, _, _, _, _) -> false.

validate_tree(N, Left, Right, Count, Visited) ->
    case lists:nth(Count + 1, Right) of
        -1 -> validate(N, Left, Right, Count + 1, [Count | Visited]);
        _ -> validate(N, Left, Right, Count + 1, [Count | Visited])
    end.