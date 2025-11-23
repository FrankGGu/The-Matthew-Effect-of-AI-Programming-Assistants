-module(solution).
-export([count_lattice_points/3]).

count_lattice_points(Radius, XCenter, YCenter) ->
    Count = fun(X, Y) ->
        (X - XCenter) * (X - XCenter) + (Y - YCenter) * (Y - YCenter) =< Radius * Radius
    end,
    lists:sum(
        lists:map(
            fun(Y) ->
                lists:map(
                    fun(X) -> if Count(X, Y) -> 1; true -> 0 end end,
                    lists:seq(XCenter - Radius, XCenter + Radius)
                )
            end,
            lists:seq(YCenter - Radius, YCenter + Radius)
        )
    ).