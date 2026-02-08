-module(food_rating).
-export([init/1, change_rating/3, highest_rated/1]).

-record(food, {name, cuisine, rating}).

init(Foods) ->
    FoodList = lists:map(fun([N, C, R]) -> #food{name=N, cuisine=C, rating=R} end, Foods),
    CuisineMap = lists:foldl(fun(Food, Acc) ->
        maps:update_with(Food#food.cuisine, fun(List) -> [Food | List] end, [Food], Acc)
    end, #{}, FoodList),
    NameMap = lists:foldl(fun(Food, Acc) ->
        maps:put(Food#food.name, Food, Acc)
    end, #{}, FoodList),
    {CuisineMap, NameMap}.

change_rating({CuisineMap, NameMap}, Name, NewRating) ->
    case maps:find(Name, NameMap) of
        {ok, Food} ->
            OldCuisine = Food#food.cuisine,
            NewFood = Food#food{rating=NewRating},
            NewNameMap = maps:put(Name, NewFood, NameMap),
            NewCuisineMap1 = maps:update_with(OldCuisine, fun(List) ->
                lists:keyreplace(Name, #food.name, List, NewFood)
            end, CuisineMap),
            {NewCuisineMap1, NewNameMap};
        error ->
            {CuisineMap, NameMap}
    end.

highest_rated({CuisineMap, _NameMap}, Cuisine) ->
    case maps:find(Cuisine, CuisineMap) of
        {ok, Foods} ->
            Sorted = lists:sort(fun(A, B) ->
                case A#food.rating =:= B#food.rating of
                    true -> A#food.name =< B#food.name;
                    false -> A#food.rating > B#food.rating
                end
            end, Foods),
            (hd(Sorted))#food.name;
        error ->
            ""
    end.