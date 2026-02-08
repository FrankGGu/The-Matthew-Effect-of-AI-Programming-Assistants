-module(buy_two_chocolates).
-export([buy_two_chocolates/2]).

buy_two_chocolates(Prices, Money) ->
  SortedPrices = lists:sort(Prices),
  case length(SortedPrices) < 2 of
    true ->
      Money;
    false ->
      First = lists:nth(1, SortedPrices),
      Second = lists:nth(2, SortedPrices),
      Cost = First + Second,
      case Cost > Money of
        true ->
          Money;
        false ->
          Money - Cost
      end
  end.