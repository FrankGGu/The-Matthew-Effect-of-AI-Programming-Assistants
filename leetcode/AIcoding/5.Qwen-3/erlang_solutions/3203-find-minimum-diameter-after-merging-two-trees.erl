-module(solution).
-export([min_diameter/1]).

min_diameter(Trees) ->
    {Roots, _} = lists:foldl(fun({Left, Right}, {Acc, Visited}) ->
                                    case lists:keyfind(Left, 1, Acc) of
                                        false -> [{Left, []}|Acc];
                                        _ -> Acc
                                    end,
                                    case lists:keyfind(Right, 1, Acc) of
                                        false -> [{Right, []}|Acc];
                                        _ -> Acc
                                    end,
                                    {lists:keystore(Left, 1, Acc, {Left, [Right | lists:keyfind(Left, 1, Acc) ++ []]}),
                                     lists:keystore(Right, 1, Visited, {Right, [Left | lists:keyfind(Right, 1, Visited) ++ []]})}
                                end, [], Trees),
    RootsSorted = lists:sort(Roots),
    MinDiameter = lists:foldl(fun(Root, Acc) ->
                                      {MaxDepth, _} = dfs(Root, -1),
                                      MaxDepth + 1
                              end, 0, RootsSorted),
    MinDiameter.

dfs(Node, Parent) ->
    {MaxDepth, _} = lists:foldl(fun(Child, {CurrentMax, CurrentSum}) ->
                                       if Child == Parent -> {CurrentMax, CurrentSum};
                                          true ->
                                              {ChildDepth, ChildSum} = dfs(Child, Node),
                                              NewMax = max(CurrentMax, ChildDepth),
                                              NewSum = CurrentSum + ChildDepth,
                                              {NewMax, NewSum}
                                      end
                              end, {0, 0}, lists:keyfind(Node, 1, Roots)),
    {MaxDepth, 0}.