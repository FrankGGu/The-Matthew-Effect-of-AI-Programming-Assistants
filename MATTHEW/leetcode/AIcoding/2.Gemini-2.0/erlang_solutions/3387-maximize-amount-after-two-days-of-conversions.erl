-module(maximize_amount).
-export([maximumAmount/2]).

maximumAmount(Amount, Conversions) ->
  maximumAmount(Amount, Conversions, 0).

maximumAmount(Amount, [], MaxAmount) ->
  max(Amount, MaxAmount);
maximumAmount(Amount, [Conversion|Conversions], MaxAmount) ->
  {Rate, Days} = Conversion,
  NewAmount = Amount * Rate,
  NewMaxAmount = max(MaxAmount, Amount),
  maximumAmount(NewAmount, Conversions, NewMaxAmount).