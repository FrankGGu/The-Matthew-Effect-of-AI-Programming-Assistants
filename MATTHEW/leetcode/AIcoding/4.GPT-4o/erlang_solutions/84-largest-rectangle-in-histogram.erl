-spec largest_rectangle_area(Heights :: [integer()]) -> integer().
largest_rectangle_area(Heights) ->
    largest_rectangle_area(Heights, [], 0, length(Heights)).

largest_rectangle_area([], [], Max, _) -> Max;
largest_rectangle_area([], Stack, Max, Length) ->
    largest_rectangle_area([], [], Max, Length);
largest_rectangle_area([H | T], Stack, Max, Length) ->
    largest_rectangle_area(T, [H | Stack], Max, Length).
