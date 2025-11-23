-module(minimum_add_valid).
-export([min_add_to_make_valid/1]).

min_add_to_make_valid(S) ->
  min_add_to_make_valid(S, 0, 0).

min_add_to_make_valid([], Open, Add) ->
  Add + Open;
min_add_to_make_valid([$( | Rest], Open, Add) ->
  min_add_to_make_valid(Rest, Open + 1, Add);
min_add_to_make_valid([$) | Rest], Open, Add) ->
  case Open > 0 of
    true ->
      min_add_to_make_valid(Rest, Open - 1, Add);
    false ->
      min_add_to_make_valid(Rest, Open, Add + 1)
  end.