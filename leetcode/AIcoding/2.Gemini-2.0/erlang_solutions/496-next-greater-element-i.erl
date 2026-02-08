-module(next_greater_element_i).
-export([next_greater_element/2]).

next_greater_element(Nums1, Nums2) ->
  Map = build_map(Nums2),
  [get_next_greater(N, Map) || N <- Nums1].

build_map(Nums) ->
  build_map(Nums, []).

build_map([], Acc) ->
  maps:from_list(lists:reverse(Acc));
build_map([H|T], Acc) ->
  build_map(T, [{H, find_next_greater(H, T)}|Acc]).

find_next_greater(_, []) ->
  -1;
find_next_greater(H, [X|T]) ->
  case X > H of
    true -> X;
    false -> find_next_greater(H, T)
  end.

get_next_greater(N, Map) ->
  maps:get(N, Map, -1).