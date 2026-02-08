-module(rearrange_array_by_sign).
-export([rearrange_array/1]).

rearrange_array(Nums) ->
  Pos = [N || N <- Nums, N > 0],
  Neg = [N || N <- Nums, N < 0],
  rearrange(Pos, Neg, []).

rearrange([], [], Acc) ->
  lists:reverse(Acc);
rearrange([P|PRest], [N|NRest], Acc) ->
  rearrange(PRest, NRest, [N, P | Acc]);
rearrange([P|PRest], [], Acc) ->
  lists:reverse(lists:append(lists:reverse(Acc), [P|PRest]));
rearrange([], [N|NRest], Acc) ->
  lists:reverse(lists:append(lists:reverse(Acc), [N|NRest])).