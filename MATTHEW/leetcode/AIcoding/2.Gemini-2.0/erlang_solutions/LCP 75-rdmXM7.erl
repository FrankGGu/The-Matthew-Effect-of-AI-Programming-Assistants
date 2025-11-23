-module(solution).
-export([solve/1]).

solve(Scrolls) ->
  solve(Scrolls, 0, 0, []).

solve([], Current_Cost, Current_Skills, Acc) ->
  {Current_Cost, Current_Skills, lists:reverse(Acc)};
solve([Scroll | Rest], Current_Cost, Current_Skills, Acc) ->
  {Cost, Skills} = Scroll,
  solve(Rest, Current_Cost + Cost, Current_Skills + Skills, [Scroll | Acc]).