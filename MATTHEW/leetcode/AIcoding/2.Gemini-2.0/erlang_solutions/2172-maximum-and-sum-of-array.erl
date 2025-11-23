-module(maximum_and_sum).
-export([maximum_and_sum/2]).

maximum_and_sum(Nums, NumSlots) ->
    N = length(Nums),
    Slots = lists:seq(1, NumSlots),
    memo(Nums, Slots, 0, N, NumSlots, []).

memo([], _Slots, Acc, _N, _NumSlots, _Visited) ->
    Acc;
memo(Nums, Slots, Acc, N, NumSlots, Visited) ->
    lists:foldl(fun(Slot, MaxAcc) ->
                      NewSlots = case lists:count(fun(X) -> X == Slot end, Visited) < 2 of
                                     true ->
                                         lists:delete(Slot, Slots);
                                     false ->
                                         Slots
                                 end,
                      case NewSlots == Slots of
                          true ->
                              MaxAcc;
                          false ->
                              [H | T] = Nums,
                              NewAcc = Acc + (H band Slot),
                              memo(T, Slots, NewAcc, N, NumSlots, [Slot|Visited]) > MaxAcc
                                  -> memo(T, Slots, NewAcc, N, NumSlots, [Slot|Visited]);
                              true -> MaxAcc
                      end
                  end, 0, Slots).