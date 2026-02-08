-module(maximum_points).
-export([maximum_points/2]).

maximum_points(Coins, Edges) ->
  N = length(Coins),
  Adj = lists:foldl(fun({U, V}, Acc) ->
                       Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                             V => lists:append(maps:get(V, Acc, []), [U])}
                    end, #{}, Edges),
  {MaxPoints, _} = dfs(1, 0, Coins, Adj, #{}),
  MaxPoints.

dfs(Node, Parent, Coins, Adj, Memo) ->
  case maps:get({Node, Parent}, Memo, undefined) of
    undefined ->
      C = lists:nth(Node, Coins),
      {MaxPoints1, MaxPoints2} =
        lists:foldl(fun(Neighbor, {Acc1, Acc2}) ->
                       case Neighbor =:= Parent of
                         true ->
                           {Acc1, Acc2};
                         false ->
                           {A1, A2} = dfs(Neighbor, Node, Coins, Adj, Memo),
                           {Acc1 + A1, Acc2 + A2}
                       end
                    end, {0, 0}, maps:get(Node, Adj, [])),

      Points1 = C - (C div 10) + MaxPoints2,
      Points2 = (C div 2) + MaxPoints1,

      Memo1 = Memo#{{Node, Parent} => {Points1, Points2}},
      {Points1, Points2};
    {P1, P2} ->
      {P1, P2}
  end.