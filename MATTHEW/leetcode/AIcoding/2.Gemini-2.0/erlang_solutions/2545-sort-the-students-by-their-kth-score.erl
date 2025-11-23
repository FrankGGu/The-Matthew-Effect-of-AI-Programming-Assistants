-module(solution).
-export([sort_the_students/2]).

sort_the_students(Score, K) ->
  lists:keysort(K + 1, lists:zip(lists:seq(1, length(Score)), Score)) .