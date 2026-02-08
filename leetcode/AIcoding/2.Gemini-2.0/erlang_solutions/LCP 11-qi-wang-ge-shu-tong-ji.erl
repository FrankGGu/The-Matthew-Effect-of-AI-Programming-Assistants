-module(solution).
-export([solve/1]).

solve(Nums) ->
  lists:foldl(fun(N, Acc) ->
                  case maps:is_key(N, Acc) of
                    true ->
                      maps:update(N, maps:get(N, Acc) + 1, Acc);
                    false ->
                      maps:put(N, 1, Acc)
                  end
                end, #{}, Nums)
  |> maps:size().