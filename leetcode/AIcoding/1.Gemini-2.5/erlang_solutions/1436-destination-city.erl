-module(solution).
-export([dest_city/1]).

-spec dest_city(Paths :: [[string()]]) -> string().
dest_city(Paths) ->
    FromCities = sets:new(),
    ToCities = sets:new(),
    {FinalFromCities, FinalToCities} = lists:foldl(
        fun([From, To], {AccFrom, AccTo}) ->
            {sets:add_element(From, AccFrom), sets:add_element(To, AccTo)}
        end,
        {FromCities, ToCities},
        Paths
    ),
    [Destination] = sets:to_list(sets:difference(FinalToCities, FinalFromCities)),
    Destination.