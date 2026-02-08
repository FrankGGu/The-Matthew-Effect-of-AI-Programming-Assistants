-spec construct_rectangle(Area :: integer()) -> [integer(), integer()].
construct_rectangle(Area) ->
    MaxW = trunc(math:sqrt(Area)),
    find_factors(Area, MaxW).

find_factors(Area, W) when Area rem W == 0 ->
    [Area div W, W];
find_factors(Area, W) ->
    find_factors(Area, W - 1).