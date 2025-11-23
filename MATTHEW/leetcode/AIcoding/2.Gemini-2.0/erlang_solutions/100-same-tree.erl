-module(same_tree).
-export([is_same_tree/2]).

-record(tree_node, {val, left, right}).

is_same_tree(P, Q) ->
  same_tree_helper(P, Q).

same_tree_helper(null, null) ->
  true;
same_tree_helper(null, _) ->
  false;
same_tree_helper(_, null) ->
  false;
same_tree_helper(#tree_node{val=ValP, left=LeftP, right=RightP}, #tree_node{val=ValQ, left=LeftQ, right=RightQ}) ->
  ValP == ValQ andalso same_tree_helper(LeftP, LeftQ) andalso same_tree_helper(RightP, RightQ).