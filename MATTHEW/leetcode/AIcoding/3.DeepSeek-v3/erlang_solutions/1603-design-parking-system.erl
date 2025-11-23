-module(parking_system).
-export([init/3, add_car/2]).

-spec init_(big :: integer(), medium :: integer(), small :: integer()) -> any().
init(Big, Medium, Small) ->
    {Big, Medium, Small}.

-spec add_car(Type :: integer()) -> boolean().
add_car({Big, Medium, Small}, Type) ->
    case Type of
        1 when Big > 0 -> {Big - 1, Medium, Small, true};
        2 when Medium > 0 -> {Big, Medium - 1, Small, true};
        3 when Small > 0 -> {Big, Medium, Small - 1, true};
        _ -> {Big, Medium, Small, false}
    end.