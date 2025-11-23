-module(wonderful_substrings).
-export([number_of_wonderful_substrings/1]).

number_of_wonderful_substrings(Word) ->
  number_of_wonderful_substrings(Word, 0, maps:from_list([{0, 1}])).

number_of_wonderful_substrings([], _, Acc) ->
  maps:fold(fun(_, V, Sum) -> Sum + (V * (V - 1) div 2) end, 0, Acc).

number_of_wonderful_substrings([C | Rest], Mask, Acc) ->
  Bit = 1 << (C - $a),
  NewMask = Mask bxor Bit,
  Count = maps:get(NewMask, Acc, 0),
  Acc1 = maps:update_with(NewMask, fun(V) -> V + 1 end, 1, Acc),
  PartialCount = lists:foldl(fun(I, Sum) ->
                                   AdjustedMask = NewMask bxor (1 << I),
                                   Sum + maps:get(AdjustedMask, Acc, 0)
                               end, 0, lists:seq(0, 9)),
  number_of_wonderful_substrings(Rest, NewMask, Acc1) + Count + PartialCount.