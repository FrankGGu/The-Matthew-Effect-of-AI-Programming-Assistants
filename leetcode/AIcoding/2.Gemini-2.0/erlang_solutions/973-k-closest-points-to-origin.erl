-module(k_closest_points).
-export([k_closest/2]).

k_closest(Points, K) ->
    lists:sublist(
        lists:keysort(1,
            lists:map(
                fun({X, Y}) ->
                    {X*X + Y*Y, {X, Y}}
                end,
                Points
            )
        ),
        K
    ).