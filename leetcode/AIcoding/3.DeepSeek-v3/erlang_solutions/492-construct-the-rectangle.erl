-spec construct_rectangle(Area :: integer()) -> [integer()].
construct_rectangle(Area) ->
    W = trunc(math:sqrt(Area)),
    find_width(Area, W).

find_width(Area, W) when Area rem W =:= 0 ->
    [Area div W, W];
find_width(Area, W) ->
    find_width(Area, W - 1).