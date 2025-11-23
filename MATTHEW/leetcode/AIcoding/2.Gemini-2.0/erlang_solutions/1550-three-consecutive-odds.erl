-module(three_consecutive_odds).
-export([three_consecutive_odds/1]).

three_consecutive_odds(Nums) ->
  three_consecutive_odds(Nums, 0).

three_consecutive_odds([], _) ->
  false;
three_consecutive_odds([N1, N2, N3 | Rest], _) ->
  case (N1 rem 2 == 1) and (N2 rem 2 == 1) and (N3 rem 2 == 1) of
    true ->
      true;
    false ->
      three_consecutive_odds([N2, N3 | Rest], 0)
  end;
three_consecutive_odds([_], _) ->
  false;
three_consecutive_odds([_,_], _) ->
  false.