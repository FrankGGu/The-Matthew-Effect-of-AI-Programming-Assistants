-module(solution).
-export([min_trio_degree/2]).

min_trio_degree(N, Edges) ->
    AdjSet = gb_sets:new(),
    Degrees = array:new({1, N}, 0),

    {FinalAdjSet, FinalDegrees} = lists:foldl(
        fun({U, V}, {AccAdjSet, AccDegrees}) ->
            NewAdjSet1 = gb_sets:add_element({U, V}, AccAdjSet),
            NewAdjSet2 = gb_sets:add_element({V, U}, NewAdjSet1),

            NewDegrees1 = array:set(U, array:get(U, AccDegrees) + 1, AccDegrees),
            NewDegrees2 = array:set(V, array:get(V, NewDegrees1) + 1, NewDegrees1),
            {NewAdjSet2, NewDegrees2}
        end,
        {AdjSet, Degrees},
        Edges
    ),

    MinTrioDegree = 1000000000,

    MinDegreeFound = find_min_trio(1, N, FinalAdjSet, FinalDegrees, MinTrioDegree),

    case MinDegreeFound of
        1000000000 -> -1;
        _ -> MinDegreeFound
    end.

find_min_trio(I, N, AdjSet, Degrees, CurrentMin) when I > N - 2 ->
    CurrentMin;
find_min_trio(I, N, AdjSet, Degrees, CurrentMin) ->
    MinAfterJLoop = find_min_trio_j(I + 1, I, N, AdjSet, Degrees, CurrentMin),
    find_min_trio(I + 1, N, AdjSet, Degrees, MinAfterJLoop).

find_min_trio_j(J, I, N, AdjSet, Degrees, CurrentMin) when J > N - 1 ->
    CurrentMin;
find_min_trio_j(J, I, N, AdjSet, Degrees, CurrentMin) ->
    MinAfterKLoop = find_min_trio_k(J + 1, I, J, N, AdjSet, Degrees, CurrentMin),
    find_min_trio_j(J + 1, I, N, AdjSet, Degrees, MinAfterKLoop).

find_min_trio_k(K, I, J, N, AdjSet, Degrees, CurrentMin) when K > N ->
    CurrentMin;
find_min_trio_k(K, I, J, N, AdjSet, Degrees, CurrentMin) ->
    IsIJConnected = gb_sets:is_element({I, J}, AdjSet),
    IsJKConnected = gb_sets:is_element({J, K}, AdjSet),
    IsIKConnected = gb_sets:is_element({I, K}, AdjSet),

    NewMin = 
        if
            IsIJConnected and IsJKConnected and IsIKConnected ->
                DegreeI = array:get(I, Degrees),
                DegreeJ = array:get(J, Degrees),
                DegreeK = array:get(K, Degrees),
                TrioDegree = DegreeI + DegreeJ + DegreeK - 6,
                min(CurrentMin, TrioDegree);
            true ->
                CurrentMin
        end,

    find_min_trio_k(K + 1, I, J, N, AdjSet, Degrees, NewMin).