-module(existence_substring).
-export([solve/2]).

solve(Source, Target) ->
  string:str(Source, Target) =/= 0 orelse
  string:str(Source, string:reverse(Target)) =/= 0.