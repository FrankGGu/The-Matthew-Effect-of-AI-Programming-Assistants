-module(solution).
-export([solve/1]).

solve(Trees) ->
    solve(Trees, []).

solve([], Acc) ->
    length(lists:usort(Acc));
solve([T | Ts], Acc) ->
    {Root, Children} = tree_to_root_children(T),
    NewAcc = Acc ++ [Root],
    solve(Ts ++ Children, NewAcc).

tree_to_root_children({Value, []}) ->
    {Value, []};
tree_to_root_children({Value, Children}) ->
    {Value, lists:map(fun(Child) -> tree_to_root_children(Child) end, Children)}.