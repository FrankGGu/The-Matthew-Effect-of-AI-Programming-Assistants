-module(repeated_substring_pattern).
-export([repeated_substring_pattern/1]).

repeated_substring_pattern(S) ->
  N = length(S),
  lists:any(fun(L) ->
    N rem L == 0 andalso
      Sub = lists:sublist(S, 1, L),
      string:copies(Sub, N div L) == S
  end, lists:seq(1, N div 2)).