-module(gray_code).
-export([gray_code/1]).

gray_code(N) ->
  lists:map(fun(I) -> I bxor (I bsr 1) end, lists:seq(0, (1 bsl N) - 1)).