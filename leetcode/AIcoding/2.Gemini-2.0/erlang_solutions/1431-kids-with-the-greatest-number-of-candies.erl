-module(kids_with_candies).
-export([kids_with_candies/2]).

kids_with_candies(Candies, ExtraCandies) ->
  MaxCandies = lists:max(Candies),
  [CandiesI + ExtraCandies >= MaxCandies || CandiesI <- Candies].