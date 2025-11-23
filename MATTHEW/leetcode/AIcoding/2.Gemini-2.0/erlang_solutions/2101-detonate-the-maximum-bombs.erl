-module(detonate_the_maximum_bombs).
-export([maximum_bombs/1]).

maximum_bombs(Bombs) ->
  N = length(Bombs),
  Graph = build_graph(Bombs),
  lists:foldl(fun(Start, Max) ->
                  NumDetonated = dfs(Start, Graph, []),
                  max(Max, NumDetonated)
              end, 0, lists:seq(1, N)).

build_graph(Bombs) ->
  N = length(Bombs),
  lists:foldl(fun(I, Acc) ->
                  lists:foldl(fun(J, Acc2) ->
                                  if
                                    I == J ->
                                      Acc2
                                  ;
                                    can_detonate(lists:nth(I, Bombs), lists:nth(J, Bombs)) ->
                                      maps:update_with(I, fun(Value) -> [J | Value] end, [J], Acc2)
                                  ;
                                    true ->
                                      Acc2
                                  end
                              end, Acc, lists:seq(1, N))
              end, #{}, lists:seq(1, N)).

can_detonate([X1, Y1, R1], [X2, Y2, _]) ->
  DistSq = (X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2),
  R1 * R1 >= DistSq.

dfs(Start, Graph, Visited) ->
  if
    lists:member(Start, Visited) ->
      0
  ;
    true ->
      Neighbors = maps:get(Start, Graph, []),
      1 + lists:sum([dfs(Neighbor, Graph, [Start | Visited]) || Neighbor <- Neighbors])
  end.