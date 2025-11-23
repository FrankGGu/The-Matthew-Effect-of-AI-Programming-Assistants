-module(reverse_odd_levels_of_binary_tree).
-export([reverse_odd_levels/1]).

-record(tree_node, {val, left, right}).

reverse_odd_levels(undefined) -> undefined;
reverse_odd_levels(Root) ->
    Levels = get_levels(Root, 0, #{}),
    ReverseLevels = reverse_odd(Levels),
    build_tree(Root, ReverseLevels, 0, 1).

get_levels(undefined, _, Acc) -> Acc;
get_levels(#tree_node{val=Val, left=Left, right=Right}, Level, Acc) ->
    Acc1 = maps:update_with(Level, fun(Vals) -> [Val | Vals] end, [Val], Acc),
    Acc2 = get_levels(Left, Level + 1, Acc1),
    get_levels(Right, Level + 1, Acc2).

reverse_odd(Acc) ->
    lists:foldl(fun({Level, Values}, Acc2) ->
        case Level rem 2 of
            1 -> maps:put(Level, lists:reverse(Values), Acc2);
            _ -> Acc2
        end
    end, #{}, maps:to_list(Acc)).

build_tree(undefined, _, _, _) -> undefined;
build_tree(#tree_node{val=Val, left=Left, right=Right}, Levels, Level, Index) ->
    CurrentLevel = maps:get(Level, Levels, []),
    NewVal = lists:nth(Index, CurrentLevel),
    LeftNode = build_tree(Left, Levels, Level + 1, 2 * Index - 1),
    RightNode = build_tree(Right, Levels, Level + 1, 2 * Index),
    #tree_node{val=NewVal, left=LeftNode, right=RightNode}.