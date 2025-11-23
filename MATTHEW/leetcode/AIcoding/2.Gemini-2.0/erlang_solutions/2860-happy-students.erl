-module(happy_students).
-export([solve/1]).

solve(Satisfaction) ->
  lists:foldl(fun(S, Acc) ->
                    if S =< Acc + 1 then
                      Acc + 1
                    else
                      Acc
                    end
                end, 0, lists:sort(Satisfaction)).