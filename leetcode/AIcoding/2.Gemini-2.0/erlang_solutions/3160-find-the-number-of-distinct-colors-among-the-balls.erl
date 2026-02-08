-module(distinct_colors).
-export([distinct_colors/1]).

distinct_colors(Balls) ->
    Colors = lists:usort([X || {X, _} <- Balls]),
    length(Colors).