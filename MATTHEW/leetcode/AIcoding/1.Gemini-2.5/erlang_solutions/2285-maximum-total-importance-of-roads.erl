-module(solution).
-export([maximum_total_importance/2]).

maximum_total_importance(N, Roads) ->
    InitialDegrees = maps:from_list([{I, 0} || I <- lists:seq(0, N - 1)]),

    DegreeMap = lists:foldl(
        fun([U, V], AccDegrees) ->
            AccDegrees1 = maps:update_with(U, fun(Val) -> Val + 1 end, 0, AccDegrees),
            maps:update_with(V, fun(Val) -> Val + 1 end, 0, AccDegrees1)
        end,
        InitialDegrees,
        Roads
    ),

    SortedDegreesByDegreeDesc = lists:sort(
        fun({D1, _C1}, {D2, _C2}) -> D1 >= D2 end,
        maps:fold(fun(City, Degree, Acc) -> [{Degree, City} | Acc] end, [], DegreeMap)
    ),

    {CityImportanceMap, _} = lists:foldl(
        fun({_Degree, City}, {AccMap, CurrentImportance}) ->
            {maps:put(City, CurrentImportance, AccMap), CurrentImportance - 1}
        end,
        {#{}, N},
        SortedDegreesByDegreeDesc
    ),

    TotalImportance = lists:foldl(
        fun([U, V], AccTotal) ->
            ImportanceU = maps:get(U, CityImportanceMap),
            ImportanceV = maps:get(V, CityImportanceMap),
            AccTotal + ImportanceU + ImportanceV
        end,
        0,
        Roads
    ),

    TotalImportance.