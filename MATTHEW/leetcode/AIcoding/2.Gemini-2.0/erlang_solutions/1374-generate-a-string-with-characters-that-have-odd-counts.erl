-module(odd_string).
-export([generate_the_string/1]).

generate_the_string(N) ->
  if N rem 2 == 0 then
    lists:duplicate(N - 1, $a) ++ [$b]
  else
    lists:duplicate(N, $a)
  end.