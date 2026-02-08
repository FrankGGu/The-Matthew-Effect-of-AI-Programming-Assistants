-module(search_in_rotated_sorted_array).
-export([search/2]).

search([], _) -> -1;
search([X], Target) when X == Target -> 0;
search([X], _) -> -1;
search(Array, Target) ->
    search(Array, Target, 0, length(Array) - 1).

search(_, _, Left, Right) when Left > Right -> -1;
search(Array, Target, Left, Right) ->
    Mid = (Left + Right) div 2,
    case array:get(Mid, Array) of
        Target -> Mid;
        Val when Val >= array:get(Left, Array) ->
            if
                Target >= array:get(Left, Array) andalso Target < Val ->
                    search(Array, Target, Left, Mid - 1);
                true ->
                    search(Array, Target, Mid + 1, Right)
            end;
        Val ->
            if
                Target > Val andalso Target <= array:get(Right, Array) ->
                    search(Array, Target, Mid + 1, Right);
                true ->
                    search(Array, Target, Left, Mid - 1)
            end
    end.