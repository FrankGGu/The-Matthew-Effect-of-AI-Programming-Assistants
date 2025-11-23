-module(longest_well_performing_interval).
-export([longestWPI/1]).

longestWPI(Hours) ->
  longestWPI(Hours, 0, 0, #{}, 0).

longestWPI([], _, _, _, Max) ->
  Max;
longestWPI([H|T], Balance, Index, Acc, Max) ->
  NewBalance = case H > 8 of
                   true -> Balance + 1;
                   false -> Balance - 1
                 end,
  NewAcc = case maps:is_key(NewBalance, Acc) of
             true -> Acc;
             false -> maps:put(NewBalance, Index + 1, Acc)
           end,
  NewMax = case NewBalance > 0 of
             true -> max(Max, Index + 1);
             false ->
               case maps:is_key(NewBalance - 1, NewAcc) of
                 true -> max(Max, Index + 1 - maps:get(NewBalance - 1, NewAcc));
                 false -> Max
               end
           end,
  longestWPI(T, NewBalance, Index + 1, NewAcc, NewMax).