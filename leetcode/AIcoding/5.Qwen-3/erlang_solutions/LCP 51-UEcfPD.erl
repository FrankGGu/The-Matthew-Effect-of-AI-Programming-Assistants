-module(cook_dishes).
-export([max_number_of_meals/1]).

max_number_of_meals(Ingredients) ->
    max_number_of_meals(Ingredients, 0).

max_number_of_meals([], _Count) ->
    _Count;
max_number_of_meals(Ingredients, Count) ->
    Counts = lists:foldl(fun(Ing, Acc) -> maps:update(Ing, Acc + 1, Acc) end, #{}, Ingredients),
    case maps:size(Counts) of
        0 -> Count;
        _ ->
            Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Counts)),
            [ {_Key, MaxCount} | _ ] = Sorted,
            if
                MaxCount >= 2 ->
                    NewIngredients = lists:foldl(fun(Ing, Acc) ->
                        case maps:get(Ing, Counts, 0) of
                            C when C == MaxCount ->
                                lists:delete(Ing, Acc);
                            _ ->
                                Acc
                        end
                    end, Ingredients, lists:seq(1, length(Ingredients))),
                    max_number_of_meals(NewIngredients, Count + 1);
                true ->
                    Count
            end
    end.