-module(tree_operations).
-export([lock/2, unlock/2, upgrade/2]).

-record(node, {locked_by = -1, children = []}).

-type node_id() :: integer().
-type user_id() :: integer().

lock(Tree, NodeId) ->
  case get_lock_status(Tree, NodeId) of
    -1 ->
      Tree#{NodeId => (Tree[NodeId])#node{locked_by = NodeId}};
    _ ->
      Tree
  end.

unlock(Tree, NodeId) ->
  case get_lock_status(Tree, NodeId) of
    NodeId ->
      Tree#{NodeId => (Tree[NodeId])#node{locked_by = -1}};
    _ ->
      Tree
  end.

upgrade(Tree, NodeId) ->
  case is_upgradeable(Tree, NodeId) of
    true ->
      NewTree = unlock_descendants(Tree, NodeId),
      NewTree2 = unlock_ancestors(NewTree, NodeId),
      NewTree2#{NodeId => (NewTree2[NodeId])#node{locked_by = NodeId}};
    false ->
      Tree
  end.

is_upgradeable(Tree, NodeId) ->
  has_locked_descendants(Tree, NodeId) and
  not has_locked_ancestors(Tree, NodeId) and
  get_lock_status(Tree, NodeId) == -1.

has_locked_descendants(Tree, NodeId) ->
  has_locked_descendants_helper(Tree, NodeId, Tree[NodeId]#node.children).

has_locked_descendants_helper(_Tree, _NodeId, []) ->
  false;
has_locked_descendants_helper(Tree, _NodeId, [Child | Rest]) ->
  case get_lock_status(Tree, Child) of
    -1 ->
      has_locked_descendants_helper(Tree, _NodeId, Rest);
    _ ->
      true
  end orelse has_locked_descendants_helper(Tree, _NodeId, Rest).

has_locked_ancestors(Tree, NodeId) ->
  has_locked_ancestors_helper(Tree, NodeId, 0, maps:keys(Tree)).

has_locked_ancestors_helper(_Tree, _NodeId, _Parent, []) ->
  false;

has_locked_ancestors_helper(Tree, NodeId, Parent, [H|T]) ->
  case find_parent(Tree, NodeId, maps:from_list([{H,Tree[H]#node.children}])) of
    0 ->
      has_locked_ancestors_helper(Tree, NodeId, Parent, T);
    ParentNodeId ->
      case get_lock_status(Tree, ParentNodeId) of
        -1 ->
          has_locked_ancestors_helper(Tree, NodeId, ParentNodeId, T);
        _ ->
          true
      end
  end.

unlock_descendants(Tree, NodeId) ->
  unlock_descendants_helper(Tree, NodeId, Tree[NodeId]#node.children).

unlock_descendants_helper(Tree, _NodeId, []) ->
  Tree;
unlock_descendants_helper(Tree, NodeId, [Child | Rest]) ->
  NewTree = case get_lock_status(Tree, Child) of
              -1 ->
                Tree;
              _ ->
                Tree#{Child => (Tree[Child])#node{locked_by = -1}}
            end,
  unlock_descendants_helper(unlock_descendants_helper(NewTree, Child, NewTree[Child]#node.children), NodeId, Rest).

unlock_ancestors(Tree, NodeId) ->
  unlock_ancestors_helper(Tree, NodeId, 0, maps:keys(Tree)).

unlock_ancestors_helper(Tree, NodeId, _Parent, []) ->
  Tree;
unlock_ancestors_helper(Tree, NodeId, Parent, [H|T]) ->
  case find_parent(Tree, NodeId, maps:from_list([{H,Tree[H]#node.children}])) of
    0 ->
      unlock_ancestors_helper(Tree, NodeId, Parent, T);
    ParentNodeId ->
      NewTree = case get_lock_status(Tree, ParentNodeId) of
                -1 ->
                  Tree;
                _ ->
                  Tree#{ParentNodeId => (Tree[ParentNodeId])#node{locked_by = -1}}
              end,
      unlock_ancestors_helper(unlock_ancestors_helper(NewTree, ParentNodeId, 0, maps:keys(NewTree)), NodeId, ParentNodeId, T)
  end.

get_lock_status(Tree, NodeId) ->
  (Tree[NodeId])#node.locked_by.

find_parent(_Tree, _NodeId, []) ->
  0;
find_parent(Tree, NodeId, Map) ->
  find_parent_helper(Tree, NodeId, maps:to_list(Map)).

find_parent_helper(_Tree, _NodeId, []) ->
  0;
find_parent_helper(Tree, NodeId, [{Parent, Children} | Rest]) ->
  case lists:member(NodeId, Children) of
    true ->
      Parent;
    false ->
      find_parent_helper(Tree, NodeId, Rest)
  end.