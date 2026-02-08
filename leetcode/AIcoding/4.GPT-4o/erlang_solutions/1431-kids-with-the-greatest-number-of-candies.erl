-module(solution).
-export([kids_with_candies/2]).

kids_with_candies(Candies, ExtraCandies) ->
    MaxCandies = lists:max(Candies),
    lists:map(fun(Candy) -> Candy + ExtraCandies >= MaxCandies end, Candies).