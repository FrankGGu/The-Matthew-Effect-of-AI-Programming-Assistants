-module(find_duplicate_subtrees).
-export([findDuplicateSubtrees/1]).

-spec findDuplicateSubtrees(TreeNode()) -> [TreeNode()].
findDuplicateSubtrees(Root) ->
  {_, Result} = findDuplicateSubtreesHelper(Root, #{}, [], #{}),
  lists:reverse(Result).

findDuplicateSubtreesHelper(null, Seen, Result, SubtreeMap) ->
  {{}, Seen, Result, SubtreeMap};
findDuplicateSubtreesHelper(TreeNode, Seen, Result, SubtreeMap) ->
  {Val, Left, Right} = TreeNode,
  {LeftSerialized, NewSeen1, NewResult1, NewSubtreeMap1} = findDuplicateSubtreesHelper(Left, Seen, Result, SubtreeMap),
  {RightSerialized, NewSeen2, NewResult2, NewSubtreeMap2} = findDuplicateSubtreesHelper(Right, NewSeen1, NewResult1, NewSubtreeMap1),
  Serialized = {Val, LeftSerialized, RightSerialized},
  case maps:is_key(Serialized, NewSubtreeMap2) of
    true ->
      case maps:is_key(Serialized, NewSeen2) of
        true ->
          {Serialized, NewSeen2, NewResult2, maps:put(Serialized, 2, NewSubtreeMap2)};
        false ->
          {Serialized, maps:put(Serialized, 1, NewSeen2), [TreeNode | NewResult2], maps:put(Serialized, 2, NewSubtreeMap2)}
      end;
    false ->
      {Serialized, NewSeen2, NewResult2, maps:put(Serialized, 1, NewSubtreeMap2)}
  end.