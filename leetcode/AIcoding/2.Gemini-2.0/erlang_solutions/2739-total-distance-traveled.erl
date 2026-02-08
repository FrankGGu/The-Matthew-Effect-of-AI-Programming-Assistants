-module(total_distance).
-export([distance/2]).

distance(mainTank, additionalTank) ->
  distance(mainTank, additionalTank, 0).

distance(0, _, Acc) ->
  Acc;
distance(MainTank, AdditionalTank, Acc) when MainTank >= 5 ->
  distance(MainTank - 5, AdditionalTank + min(MainTank - 5, 0), Acc + 50);
distance(MainTank, AdditionalTank, Acc) ->
  distance(0, AdditionalTank - (5 - MainTank), Acc + MainTank * 10).