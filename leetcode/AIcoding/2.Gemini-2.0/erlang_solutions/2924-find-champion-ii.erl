-module(find_champion_ii).
-export([find_champion_ii/2]).

find_champion_ii(N, Edges) ->
  Indegrees = lists:foldl(fun([_, To], Acc) ->
                                 maps:update(To, maps:get(To, Acc, 0) + 1, Acc)
                             end,
                             maps:new(),
                             Edges),

  case lists:filter(fun(I) -> not maps:is_key(I, Indegrees) end, lists:seq(1, N)) of
    [Champion] -> Champion;
    _ -> -1
  end.