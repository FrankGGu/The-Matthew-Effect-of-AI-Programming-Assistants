-module(food_rating_system).
-export([new/0, change_rate/3, highest_rated/1]).

-record(state, {cuisine_map = dict:new(), food_map = dict:new()}).

new() ->
    #state{}.

change_rate(Cuisine, Food, NewRate) ->
    State = new(),
    CuisineMap = dict:store(Cuisine, NewRate, State#state.cuisine_map),
    FoodMap = dict:store(Food, NewRate, State#state.food_map),
    State#state{cuisine_map = CuisineMap, food_map = FoodMap}.

highest_rated(Cuisine) ->
    case dict:find(Cuisine, #state.cuisine_map) of
        {ok, Rate} ->
            case dict:find(Rate, #state.food_map) of
                {ok, Food} -> Food;
                _ -> error
            end;
        _ -> error
    end.