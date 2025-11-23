-module(FoodRatingSystem).
-export([new/0, addFood/3, changeRating/3, highestRated/1]).

-record(food, {name, rating}).

new() ->
    {ok, dict:new()}.

addFood(FoodSystem, Name, Rating) ->
    FoodDict = dict:store(Name, #food{name=Name, rating=Rating}, FoodSystem),
    {ok, FoodDict}.

changeRating(FoodSystem, Name, NewRating) ->
    case dict:find(Name, FoodSystem) of
        {ok, Food} ->
            UpdatedFood = Food#food{rating=NewRating},
            FoodDict = dict:store(Name, UpdatedFood, FoodSystem),
            {ok, FoodDict};
        error ->
            {error, not_found}
    end.

highestRated(FoodSystem) ->
    {ok, HighestRated} = dict:fold(fun(_, #food{rating=Rating} = Food, {MaxRating, MaxFood}) ->
        if
            Rating > MaxRating -> {Rating, Food};
            true -> {MaxRating, MaxFood}
        end
    end, {0, undefined}, FoodSystem),
    case HighestRated of
        {Rating, Food} -> Food#food{name=Food#food.name, rating=Rating};
        _ -> undefined
    end.