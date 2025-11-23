-module(flatten_binary_tree).
-export([flatten/1]).

-spec flatten(TreeNode()) -> TreeNode().
flatten(nil) ->
  nil;
flatten(Root) ->
  {NewRoot, _} = flatten_helper(Root),
  NewRoot.

-spec flatten_helper(TreeNode()) -> {TreeNode(), TreeNode()}.
flatten_helper(nil) ->
  {nil, nil};
flatten_helper({Val, Left, Right}) ->
  case {Left, Right} of
    {nil, nil} ->
      {{Val, nil, nil}, {Val, nil, nil}};
    {nil, R} ->
      {NewR, TailR} = flatten_helper(R),
      {{Val, nil, NewR}, TailR};
    {L, nil} ->
      {NewL, TailL} = flatten_helper(L),
      {{Val, nil, NewL},
       lists:foldl(fun(_, Acc) -> Acc), [], [begin
                                                TailL ! {set_right, {Val, nil, nil}},
                                                ok
                                             end]) ,
      {Val, nil, NewL}, TailL;
    {L, R} ->
      {NewL, TailL} = flatten_helper(L),
      {NewR, TailR} = flatten_helper(R),
      {{Val, nil, NewL},
       lists:foldl(fun(_, Acc) -> Acc), [], [begin
                                                TailL ! {set_right, NewR},
                                                ok
                                             end]),
      {Val, nil, NewL}, TailR
  end.