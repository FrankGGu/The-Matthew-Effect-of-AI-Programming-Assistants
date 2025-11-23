-module(good_paths).
-export([number_of_good_paths/2]).

number_of_good_paths(Vals, Edges) ->
  N = length(Vals),
  Parent = lists:seq(1, N),
  Size = lists:duplicate(N, 1),

  find(X, Parent) ->
    if X == lists:nth(X, Parent) then
      X
    else
      P = find(lists:nth(X, Parent), Parent),
      lists:nth(X, Parent) = P,
      P
    end.

  union(X, Y, Parent, Size) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if RootX == RootY then
      {Parent, Size}
    else
      if lists:nth(RootX, Size) < lists:nth(RootY, Size) then
        lists:nth(RootX, Parent) = RootY,
        lists:nth(RootY, Size) = lists:nth(RootY, Size) + lists:nth(RootX, Size),
        {Parent, Size}
      else
        lists:nth(RootY, Parent) = RootX,
        lists:nth(RootX, Size) = lists:nth(RootX, Size) + lists:nth(RootY, Size),
        {Parent, Size}
      end
    end.

  SortedEdges = lists:sort([ {max(lists:nth(U+1, Vals), lists:nth(V+1, Vals)), U+1, V+1} || {U, V} <- Edges ]),

  FoldFun = fun({Val, U, V}, {Acc, ParentAcc, SizeAcc}) ->
    {NewParent, NewSize} = union(U, V, ParentAcc, SizeAcc),
    {Acc, NewParent, NewSize}
  end.

  {_, FinalParent, _} = lists:foldl(FoldFun, {0, Parent, Size}, SortedEdges),

  GroupedNodes = lists:foldl(fun(I, Acc) ->
                                  Root = find(I, FinalParent),
                                  case lists:keyfind(Root, 1, Acc) of
                                    false ->
                                      [{Root, [I]} | Acc];
                                    {Root, Nodes} ->
                                      lists:keyreplace(Root, 1, Acc, {Root, [I | Nodes]})
                                  end
                              end, [], lists:seq(1,N)),

  Result = lists:sum([ count_nodes_with_same_value(Nodes, Vals) || {_Root, Nodes} <- GroupedNodes]),

  Result.

count_nodes_with_same_value(Nodes, Vals) ->
  ValueCounts = lists:foldl(fun(Node, Acc) ->
                                  Val = lists:nth(Node, Vals),
                                  case lists:keyfind(Val, 1, Acc) of
                                    false ->
                                      [{Val, 1} | Acc];
                                    {Val, Count} ->
                                      lists:keyreplace(Val, 1, Acc, {Val, Count + 1})
                                  end
                              end, [], Nodes),

  lists:sum([ (C * (C - 1)) div 2 || {_Val, C} <- ValueCounts]).