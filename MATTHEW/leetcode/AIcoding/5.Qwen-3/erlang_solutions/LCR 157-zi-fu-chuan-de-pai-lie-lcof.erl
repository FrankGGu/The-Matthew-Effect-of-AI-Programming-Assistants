-module(solution).
-export([get_number/1]).

get_number(Items) ->
    get_number(Items, 0).

get_number([], _Count) ->
    0;
get_number([H | T], Count) ->
    case H of
        "Burger" -> get_number(T, Count + 3);
        "Fries" -> get_number(T, Count + 2);
        "Drink" -> get_number(T, Count + 1);
        _ -> get_number(T, Count)
    end.