-module(sum_queries).
-export([handle_queries/2]).

handle_queries(Nums, Queries) ->
  handle_queries(Nums, Queries, []).

handle_queries(Nums, [], Acc) ->
  lists:reverse(Acc);
handle_queries(Nums, [{1, L, R} | Rest], Acc) ->
  NewNums = update_range(Nums, L, R),
  handle_queries(NewNums, Rest, Acc);
handle_queries(Nums, [{0, P} | Rest], Acc) ->
  Sum = sum(Nums),
  handle_queries(Nums, Rest, [Sum | Acc]).

update_range(Nums, L, R) ->
  update_range(Nums, L, R, []).

update_range(Nums, L, R, Acc) ->
  update_range(Nums, L, R, 0, Nums, Acc).

update_range(_Nums, _L, _R, I, [], Acc) ->
  lists:reverse(Acc);
update_range(Nums, L, R, I, [H | T], Acc) ->
  if
    I >= L, I =< R ->
      update_range(Nums, L, R, I + 1, T, [1 - H | Acc]);
    true ->
      update_range(Nums, L, R, I + 1, T, [H | Acc])
  end.

sum(Nums) ->
  sum(Nums, 0).

sum([], Acc) ->
  Acc;
sum([H | T], Acc) ->
  sum(T, Acc + H).