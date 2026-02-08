-spec square_is_white(Coordinates :: unicode:unicode_binary()) -> boolean().
square_is_white(Coordinates) ->
    <<X, Y>> = Coordinates,
    (X - $a + Y - $1) rem 2 =/= 0.