-module(count_pairs).
-export([number_of_pairs/2]).

number_of_pairs(Points, K) ->
  number_of_pairs(Points, K, 0).

number_of_pairs([], _, Acc) ->
  Acc;
number_of_pairs([Point | Rest], K, Acc) ->
  NewAcc = Acc + lists:foldl(fun(OtherPoint, Count) ->
                                 if distance(Point, OtherPoint, K) then
                                   Count + 1
                                 else
                                   Count
                                 end
                               end, 0, Rest),
  number_of_pairs(Rest, K, NewAcc).

distance([X1, Y1], [X2, Y2], K) ->
  (X1 band X2) + (Y1 band Y2) + (X1 bor X2) + (Y1 bor Y2) =:= K.