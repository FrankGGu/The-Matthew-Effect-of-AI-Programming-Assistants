-module(solution).
-export([flip_and_invert_image/1]).

flip_and_invert_image(Image) ->
    lists:map(fun(Row) ->
        lists:map(fun(X) -> if X == 0 -> 1; X == 1 -> 0 end end, lists:reverse(Row))
    end, Image).