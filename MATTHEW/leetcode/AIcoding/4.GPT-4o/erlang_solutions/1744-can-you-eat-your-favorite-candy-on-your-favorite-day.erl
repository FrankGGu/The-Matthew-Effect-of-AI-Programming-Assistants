-module(solution).
-export([can_eat/3]).

can_eat(FavoriteCandy, FavoriteDay, Queries) ->
    lists:map(fun({candyType, day, amount}) ->
        TotalCandies = lists:nth(candyType + 1, FavoriteCandy),
        TotalDays = lists:nth(candyType + 1, FavoriteDay),
        CanEat = (amount > day) andalso (day + 1) * TotalDays > TotalCandies + amount,
        CanEat
    end, Queries).