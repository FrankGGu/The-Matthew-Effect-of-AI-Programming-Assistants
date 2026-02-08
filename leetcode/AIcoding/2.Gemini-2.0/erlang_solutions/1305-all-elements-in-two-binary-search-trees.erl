-module(all_elements_in_two_bst).
-export([all_elements/2]).

-spec all_elements(TreeNode(), TreeNode()) -> [integer()].
all_elements(Root1, Root2) ->
  List1 = inorder(Root1, []),
  List2 = inorder(Root2, []),
  merge(List1, List2, []).

-spec inorder(TreeNode(), [integer()]) -> [integer()].
inorder(null, Acc) ->
  Acc;
inorder(TreeNode{val = Val, left = Left, right = Right}, Acc) ->
  inorder(Right, [Val | inorder(Left, Acc)]).

-spec merge([integer()], [integer()], [integer()]) -> [integer()].
merge([], List2, Acc) ->
  lists:reverse(lists:append(Acc, List2));
merge(List1, [], Acc) ->
  lists:reverse(lists:append(Acc, List1));
merge([H1 | T1], [H2 | T2], Acc) ->
  if
    H1 =< H2 ->
      merge(T1, [H2 | T2], [H1 | Acc]);
    true ->
      merge([H1 | T1], T2, [H2 | Acc])
  end.