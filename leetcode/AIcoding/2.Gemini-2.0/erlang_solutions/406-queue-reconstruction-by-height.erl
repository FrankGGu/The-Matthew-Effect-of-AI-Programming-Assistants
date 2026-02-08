-module(queue_reconstruction).
-export([reconstruct_queue/1]).

reconstruct_queue(People) ->
  lists:reverse(reconstruct_queue_helper(lists:sort(fun({H1, K1}, {H2, K2}) -> H1 < H2 orelse (H1 == H2 and K1 > K2) end, People), [])).

reconstruct_queue_helper([], Acc) ->
  Acc;
reconstruct_queue_helper([{H, K} | Rest], Acc) ->
  reconstruct_queue_helper(Rest, insert_at({H,K}, K, Acc)).

insert_at(Element, Index, List) ->
  insert_at_helper(Element, Index, List, []).

insert_at_helper(Element, 0, List, Acc) ->
  lists:reverse(Acc) ++ [Element] ++ List;
insert_at_helper(Element, Index, [H | T], Acc) ->
  insert_at_helper(Element, Index - 1, T, [H | Acc]);
insert_at_helper(Element, Index, [], Acc) ->
  lists:reverse(Acc) ++ [Element].