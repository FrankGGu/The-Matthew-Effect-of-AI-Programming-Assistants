-module(food_rating).
-export([start/0, add_food/3, change_rating/2, highest_rated/1]).

start() ->
    {ok, #state{foods = dict:new(), cuisines = dict:new(), ratings = dict:new()}}.

add_food(State, Food, Cuisine, Rating) ->
    NewState = #state{
        foods = dict:store(Food, Cuisine, State#state.foods),
        cuisines = dict:append(Cuisine, {Food, Rating}, State#state.cuisines),
        ratings = dict:store(Food, Rating, State#state.ratings)
    },
    rebuild_cuisine_ratings(NewState, Cuisine).

change_rating(State, Food, NewRating) ->
    Cuisine = dict:fetch(Food, State#state.foods),
    OldRating = dict:fetch(Food, State#state.ratings),
    NewState = #state{
        ratings = dict:store(Food, NewRating, State#state.ratings),
        cuisines = lists:keyreplace(Cuisine, 1, State#state.cuisines, {Food, NewRating})
    },
    rebuild_cuisine_ratings(NewState, Cuisine).

highest_rated(State, Cuisine) ->
    case dict:find(Cuisine, State#state.cuisines) of
        {ok, List} ->
            Sorted = lists:keysort(2, List),
            {Food, _} = hd(lists:reverse(Sorted)),
            Food;
        error ->
            []
    end.

rebuild_cuisine_ratings(State, Cuisine) ->
    Foods = case dict:find(Cuisine, State#state.cuisines) of
        {ok, List} -> List;
        error -> []
    end,
    Ratings = lists:map(fun({Food, _}) -> {Food, dict:fetch(Food, State#state.ratings)} end, Foods),
    NewState = #state{
        foods = State#state.foods,
        cuisines = dict:store(Cuisine, Ratings, State#state.cuisines),
        ratings = State#state.ratings
    },
    NewState.

-record(state, {foods, cuisines, ratings}).