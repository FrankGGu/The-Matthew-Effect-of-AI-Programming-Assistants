-module(binary_string_with_substrings).
-export([solve/2]).

solve(S, N) ->
  lists:all(fun(I) -> string:str(S, integer_to_binary(I)) > 0 end, lists:seq(N div 2 + 1, N)).