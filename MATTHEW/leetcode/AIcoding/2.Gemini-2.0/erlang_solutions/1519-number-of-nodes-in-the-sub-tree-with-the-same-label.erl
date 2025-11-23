-module(subtree_labels).
-export([count_subtrees/2]).

count_subtrees(N, Edges, Labels) ->
  Graph = lists:foldl(fun([U, V], Acc) ->
                           Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                               V => lists:append(maps:get(V, Acc, []), [U])}
                         end, #{}, Edges),
  LabelsList = string:to_list(Labels),
  {_, Result} = dfs(1, 0, Graph, LabelsList, array:new(N+1, {fixed, undefined})),
  array:to_list(Result, 1).

dfs(Node, Parent, Graph, Labels, Result) ->
  Label = lists:nth(Node - 1, Labels),
  Children = lists:filter(fun(Child) -> Child /= Parent end, maps:get(Node, Graph, [])),

  {UpdatedResult, LabelCounts} = lists:foldl(fun(Child, {AccResult, AccCounts}) ->
                                                 {ChildResult, ChildCounts} = dfs(Child, Node, Graph, Labels, AccResult),
                                                 {ChildResult, merge_counts(AccCounts, ChildCounts)}
                                              end, {Result, #{}}, Children),

  NewLabelCounts = maps:update_with(Label, fun(Count) -> Count + 1 end, 1, LabelCounts),
  CountForNode = maps:get(Label, NewLabelCounts, 0),
  UpdatedResult2 = array:set(Node, CountForNode, UpdatedResult),
  {UpdatedResult2, NewLabelCounts}.

merge_counts(Counts1, Counts2) ->
  maps:fold(fun(Label, Count, Acc) ->
               maps:update_with(Label, fun(C) -> C + Count end, Count, Acc)
            end, Counts2, Counts1).