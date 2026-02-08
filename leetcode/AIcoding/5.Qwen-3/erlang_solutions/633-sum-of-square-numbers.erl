-module(solution).
-export([judge_square_sum/1]).

judge_square_sum(N) ->
    Max = trunc(math:sqrt(N)),
    lists:all(fun(X) -> lists:any(fun(Y) -> X*X + Y*Y == N end, lists:seq(0, Max)) end, lists:seq(0, Max)).