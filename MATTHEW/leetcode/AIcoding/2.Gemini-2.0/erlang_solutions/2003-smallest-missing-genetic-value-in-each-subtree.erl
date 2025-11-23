-module(smallest_missing_genetic_value).
-export([smallest_missing_value_subtree/2]).

smallest_missing_value_subtree(Parents, Nums) ->
    tree_map(Parents, Nums).

tree_map(Parents, Nums) ->
    Tree = build_tree(Parents),
    calculate_values(Tree, Nums).

build_tree(Parents) ->
    build_tree(Parents, length(Parents), []).

build_tree([], _, Acc) ->
    Acc;
build_tree(Parents, N, Acc) ->
    build_tree(tl(Parents), N, insert_child(hd(Parents), N, Acc)).

insert_child(-1, _, Acc) ->
    [{root, undefined} | Acc];
insert_child(Parent, N, Acc) ->
    case lists:keyfind(Parent, 1, Acc) of
        {Parent, Children} ->
            lists:keyreplace(Parent, 1, Acc, {Parent, [N | Children]});
        false ->
            [{Parent, [N]} | Acc]
    end.

calculate_values(Tree, Nums) ->
    calculate_values(Tree, Nums, length(Nums)).

calculate_values(Tree, Nums, N) ->
    calculate_values(Tree, Nums, N, []).

calculate_values(_Tree, _Nums, 0, Acc) ->
    lists:reverse(Acc);
calculate_values(Tree, Nums, N, Acc) ->
    Value = find_smallest_missing(Tree, Nums, N - 1),
    calculate_values(Tree, Nums, N - 1, [Value | Acc]).

find_smallest_missing(Tree, Nums, Node) ->
    if Nums =/= [], Nums[Node + 1] =:= 1 ->
        find_smallest_missing_helper(Tree, Nums, Node, 1, sets:new());
       true ->
        1
    end.

find_smallest_missing_helper(Tree, Nums, Node, Missing, Seen) ->
    UpdatedSeen = include_subtree(Tree, Nums, Node, Seen),
    if sets:is_element(Missing, UpdatedSeen) ->
        find_smallest_missing_helper(Tree, Nums, Node, Missing + 1, UpdatedSeen);
       true ->
        Missing
    end.

include_subtree(Tree, Nums, Node, Seen) ->
    Seen1 = sets:add_element(Nums[Node + 1], Seen),
    case lists:keyfind(Node, 1, Tree) of
        {Node, Children} ->
            lists:foldl(fun(Child, Acc) ->
                                 include_subtree(Tree, Nums, Child, Acc)
                         end,
                         Seen1,
                         Children);
        false ->
            Seen1
    end.