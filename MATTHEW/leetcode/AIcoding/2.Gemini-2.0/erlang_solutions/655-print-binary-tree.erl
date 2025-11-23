-module(print_binary_tree).
-export([print_tree/1]).

-spec print_tree(TreeNode()) -> [[string()]].
print_tree(Root) ->
  Height = tree_height(Root),
  Width = math:pow(2, Height) - 1,
  Matrix = lists:duplicate(Height, lists:duplicate(Width, "")),
  fill_matrix(Root, Matrix, 0, 0, Width - 1),
  Matrix.

-spec tree_height(TreeNode()) -> integer().
tree_height(nil) -> 0;
tree_height(TreeNode) -> 1 + max(tree_height(TreeNode#tree_node.left), tree_height(TreeNode#tree_node.right)).

-spec fill_matrix(TreeNode(), [[string()]], integer(), integer(), integer()) -> [[string()]].
fill_matrix(nil, Matrix, Row, Left, Right) ->
  Matrix;
fill_matrix(TreeNode, Matrix, Row, Left, Right) ->
  Mid = (Left + Right) div 2,
  Value = integer_to_list(TreeNode#tree_node.val),
  NewMatrix = set_element(Matrix, Row, Mid, Value),
  NewMatrix2 = fill_matrix(TreeNode#tree_node.left, NewMatrix, Row + 1, Left, Mid - 1),
  fill_matrix(TreeNode#tree_node.right, NewMatrix2, Row + 1, Mid + 1, Right).

-spec set_element([[string()]], integer(), integer(), string()) -> [[string()]].
set_element(Matrix, Row, Col, Value) ->
  lists:nth(Row + 1, Matrix) ! lists:nth(Row + 1, Matrix) ++ [setelement(Col + 1, lists:nth(Row + 1, Matrix), Value)],
  lists:nth(Row + 1, Matrix, lists:setval(Col, Value, lists:nth(Row + 1, Matrix))),
  lists:replace_nth(Row, Matrix, lists:replace_nth(Col, lists:nth(Row, Matrix), Value)).

-record(tree_node, {val, left, right}).

-type TreeNode() :: #tree_node{val :: integer(), left :: TreeNode(), right :: TreeNode()} | nil.

-spec max(integer(), integer()) -> integer().
max(A, B) ->
  if A > B -> A;
     true -> B
  end.