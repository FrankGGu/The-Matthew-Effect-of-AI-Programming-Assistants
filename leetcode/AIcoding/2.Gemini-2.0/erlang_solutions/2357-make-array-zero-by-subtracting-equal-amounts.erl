-module(make_array_zero).
-export([minimum_operations/1]).

minimum_operations(Nums) ->
    minimum_operations(Nums, sets:new()).

minimum_operations([], Set) ->
    sets:size(Set);
minimum_operations([H|T], Set) ->
    case H > 0 of
        true ->
            minimum_operations(T, sets:add_element(H, Set));
        false ->
            minimum_operations(T, Set)
    end.