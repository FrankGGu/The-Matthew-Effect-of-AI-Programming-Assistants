-module(solution).
-export([min_garden_perimeter/1]).

min_garden_perimeter(N) ->
    Area = N div 2 + 1,
    Perimeter = 2 * (math:ceil(math:sqrt(Area)) + math:floor(math:sqrt(Area))),
    Perimeter.