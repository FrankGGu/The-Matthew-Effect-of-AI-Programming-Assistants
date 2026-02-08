-module(solution).
-export([connect_trees/2]).

connect_trees(Trees, Target) ->
    Nodes = lists:foldl(fun({Left, Right}, Acc) -> 
        [Left | [Right | Acc]] end, [], Trees),
    Count = count_target(Nodes, Target),
    Count.

count_target([], _) -> 0;
count_target([Node | Rest], Target) ->
    case Node of
        Target -> 1 + count_target(Rest, Target);
        _ -> count_target(Rest, Target)
    end.