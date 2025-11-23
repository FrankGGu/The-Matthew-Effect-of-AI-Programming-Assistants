-module(solution).
-export([get_max_generated/1]).

get_max_generated(N) when N < 2 -> N;
get_max_generated(N) ->
    Array = lists:duplicate(N + 1, 0),
    Array1 = lists:map(fun(X) -> case X of
                                      0 -> 0;
                                      1 -> 1;
                                      _ -> Array1[div(X, 2)] + Array1[div(X - 1, 2)]
                                  end
                       end, lists:seq(0, N)),
    lists:max(Array1).