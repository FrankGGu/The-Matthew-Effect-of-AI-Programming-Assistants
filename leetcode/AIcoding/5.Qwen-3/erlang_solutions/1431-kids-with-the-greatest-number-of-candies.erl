-module(solution).
-export([kids_with_candies/1]).

kids_with_candies(Candies) ->
    Max = lists:max(Candies),
    [ (C + lists:last(Candies)) >= Max || C <- Candies ].