-module(kth_ancestor).

-export([new/1, get_kth_ancestor/3]).

-type node = integer().
-type k = integer().
-type parent_map = #{node() => node()}.

-record(ancestor_tree, {
    parent_map :: parent_map
}).

new(N) ->
    #ancestor_tree{parent_map = #{}}.

get_kth_ancestor(ATree, Node, K) ->
    get_kth_ancestor_helper(ATree#ancestor_tree.parent_map, Node, K).

get_kth_ancestor_helper(_ParentMap, Node, 0) ->
    Node;
get_kth_ancestor_helper(ParentMap, Node, K) when K > 0 ->
    case maps:get(Node, ParentMap, undefined) of
        undefined ->
            -1;
        Parent ->
            get_kth_ancestor_helper(ParentMap, Parent, K - 1)
    end.

-export([add_edge/3]).

add_edge(ATree, Parent, Child) ->
    NewParentMap = maps:put(Child, Parent, ATree#ancestor_tree.parent_map),
    ATree#ancestor_tree{parent_map = NewParentMap}.