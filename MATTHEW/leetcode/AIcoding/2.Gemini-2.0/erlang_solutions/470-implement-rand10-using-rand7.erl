-module(rand10).
-export([rand10/0]).

rand7() ->
  rand:uniform(7).

rand10() ->
  X = 7 * (rand7() - 1) + rand7() - 1,
  if X < 40 ->
    X rem 10 + 1;
  true ->
    rand10()
  end.