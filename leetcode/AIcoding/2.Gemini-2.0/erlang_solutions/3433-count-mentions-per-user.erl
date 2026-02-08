-module(solution).
-export([solve/1]).

solve(Mentions) ->
  lists:foldl(
    fun({Mentioner, Mentionee}, Acc) ->
      Acc1 = maps:update_with(Mentioner, fun(V) -> V + 1 end, 1, Acc),
      maps:update_with(Mentionee, fun(V) -> V + 0 end, 0, Acc1)
    end,
    maps:new(),
    Mentions
  ).