-module(solution).
-export([execute_ops/2]).

execute_ops(Operations, Nodes) ->
    Tree = build_tree(Nodes),
    lists:foldl(fun(Op, Acc) -> apply_op(Op, Acc) end, Tree, Operations).

build_tree(Nodes) ->
    lists:foldl(fun({Id, Parent}, Acc) -> 
        case maps:is_key(Parent, Acc) of
            true -> 
                maps:update_with(Parent, fun(Children) -> [Id | Children] end, Acc);
            false -> 
                maps:put(Id, [], maps:put(Parent, [Id], Acc))
        end
    end, #{}, Nodes).

apply_op({add, Id, Val}, Tree) ->
    maps:update_with(Id, fun(V) -> V + Val end, Tree);

apply_op({set, Id, Val}, Tree) ->
    maps:put(Id, Val, Tree);

apply_op({get, Id}, Tree) ->
    maps:get(Id, Tree).