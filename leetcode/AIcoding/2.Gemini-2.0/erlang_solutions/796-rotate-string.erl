-module(rotate_string).
-export([rotate_string/2]).

rotate_string(S, Goal) ->
  LenS = length(S),
  LenGoal = length(Goal),
  if LenS =/= LenGoal then
    false
  else
    NewS = S ++ S,
    string:str(NewS, Goal) > 0
  end.