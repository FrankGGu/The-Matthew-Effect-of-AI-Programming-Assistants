-spec calculate(S :: unicode:unicode_binary()) -> integer().
calculate(S) ->
    calculate(S, 1, 0).

calculate(<<>>, X, Y) ->
    X + Y;
calculate(<<"A">> ++ Rest, X, Y) ->
    calculate(Rest, X + Y, Y);
calculate(<<"B">> ++ Rest, X, Y) ->
    calculate(Rest, X, X + Y).