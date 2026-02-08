-module(solution).
-export([range_product_queries/2]).

range_product_queries(N, Queries) ->
  Powers = powers(N, 2, []),
  lists:map(fun(Query) -> product_range(Powers, Query) end, Queries).

powers(N, Base, Acc) ->
  if N =:= 0 orelse N rem Base /= 0 ->
    lists:reverse(Acc)
  else
    powers(N div Base, Base, [length(Acc) | Acc]).

product_range(Powers, [L, R]) ->
  product_range_helper(Powers, L, R, 1, 1000000007).

product_range_helper([], _, _, Acc, _) ->
  Acc;
product_range_helper([H | T], L, R, Acc, Mod) ->
  if H >= L and H =< R ->
    product_range_helper(T, L, R, (Acc * erlang:pow(2, H)) rem Mod, Mod)
  else
    product_range_helper(T, L, R, Acc, Mod)
  end.