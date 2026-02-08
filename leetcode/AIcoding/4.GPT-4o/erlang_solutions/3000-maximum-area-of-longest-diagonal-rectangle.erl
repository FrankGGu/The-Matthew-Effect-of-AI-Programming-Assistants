-module(solution).
-export([max_area/2]).

max_area(Length, Width) ->
    Area = Length * Width,
    Area.