-module(solution).
-export([alternating_sum/1]).

alternating_sum(N) when N < 0 -> 0;
alternating_sum(N) ->
    digits = integer_to_list(N),
    lists:foldl(fun(D, {Sum, Sign}) ->
                      {Sum + (Sign * (D - $0)), -Sign}
                  end, {0, 1}, lists:map(fun(X) -> (X - $0) end, digits)).