-module(sum_distances_in_tree).
-export([sum_distances_in_tree/2]).

sum_distances_in_tree(N, Edges) ->
  Adj = lists:foldl(fun({U, V}, Acc) ->
                        Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                              V => lists:append(maps:get(V, Acc, []), [U])}
                    end, #{}, Edges),
  {Size, Ans, Sum} = dfs1(1, 0, Adj, #{}),
  AnsList = maps:to_list(Ans),
  lists:sort([ {K, V} || {K, V} <- AnsList]).

dfs1(Node, Parent, Adj, Acc) ->
  Neighbors = lists:filter(fun(N) -> N /= Parent end, maps:get(Node, Adj, [])),
  {Size, Sum} = lists:foldl(fun(Neighbor, {SizeAcc, SumAcc}) ->
                                {SizeN, AnsN, SumN} = dfs1(Neighbor, Node, Adj, Acc),
                                {SizeAcc + SizeN, SumAcc + SumN + SizeN}
                            end, {1, 0}, Neighbors),
  NewAcc = Acc#{Node => Sum},
  {Size, NewAcc, Sum}.