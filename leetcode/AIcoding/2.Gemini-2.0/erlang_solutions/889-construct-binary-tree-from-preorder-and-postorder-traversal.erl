-module(construct_binary_tree).
-export([construct_from_pre_post/2]).

construct_from_pre_post(Preorder, Postorder) ->
  construct(Preorder, 0, length(Preorder) - 1, Postorder, 0, length(Postorder) - 1).

construct(Preorder, PreStart, PreEnd, Postorder, PostStart, PostEnd) ->
  if
    PreStart > PreEnd ->
      null;
    true ->
      RootVal = lists:nth(PreStart + 1, Preorder),
      if
        PreStart == PreEnd ->
          {value, RootVal, null, null};
        true ->
          LRootVal = lists:nth(PreStart + 2, Preorder),
          LIndex = find_index(Postorder, LRootVal, PostStart, PostEnd),
          LSize = LIndex - PostStart + 1,

          LTree = construct(Preorder, PreStart + 1, PreStart + 1 + LSize - 1, Postorder, PostStart, LIndex),
          RTree = construct(Preorder, PreStart + 1 + LSize, PreEnd, Postorder, LIndex + 1, PostEnd - 1),
          {value, RootVal, LTree, RTree}
      end
  end.

find_index(List, Value, Start, End) ->
  find_index_helper(List, Value, Start, End, 1).

find_index_helper(List, Value, Start, End, Index) ->
  if
    Start > End ->
      -1;
    true ->
      if
        lists:nth(Start + Index, List) == Value ->
          Start + Index;
        true ->
           find_index_helper(List, Value, Start, End, Index + 1)
      end
  end.