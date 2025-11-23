-module(solution).
-export([kidsWithCandies/2]).

kidsWithCandies(Candies, ExtraCandies) ->
    MaxCandies = lists:max(Candies),
    lists:map(fun(KidCandies) ->
        KidCandies + ExtraCandies >= MaxCandies
    end, Candies).