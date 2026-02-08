-module(gray_code).
-export([gray_code/1]).

gray_code(0) -> [0];
gray_code(N) ->
    Prev = gray_code(N - 1),
    [X + 2^(N-1) || X <- Prev] ++ Prev.