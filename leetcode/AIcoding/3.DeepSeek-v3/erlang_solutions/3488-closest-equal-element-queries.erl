-module(solution).
-export([closest_equal/2]).

closest_equal(Arr, Queries) ->
    IndexMap = build_index_map(Arr, 0, #{}),
    process_queries(Queries, Arr, IndexMap, []).

build_index_map([], _, Map) -> Map;
build_index_map([H|T], Index, Map) ->
    case maps:get(H, Map, none) of
        none -> NewMap = maps:put(H, [Index], Map);
        List -> NewMap = maps:put(H, [Index|List], Map)
    end,
    build_index_map(T, Index + 1, NewMap).

process_queries([], _, _, Acc) -> lists:reverse(Acc);
process_queries([{Pos, Val}|T], Arr, IndexMap, Acc) ->
    case maps:get(Val, IndexMap, none) of
        none -> 
            process_queries(T, Arr, IndexMap, [-1|Acc]);
        Indices ->
            Sorted = lists:sort(Indices),
            Closest = find_closest(Sorted, Pos),
            process_queries(T, Arr, IndexMap, [Closest|Acc])
    end.

find_closest(Indices, Pos) ->
    find_closest(Indices, Pos, -1, -1, infinity).

find_closest([], _, BestIndex, _, _) -> BestIndex;
find_closest([H|T], Pos, BestIndex, LastIndex, MinDist) ->
    Dist = abs(H - Pos),
    if
        Dist == 0 -> 
            find_closest(T, Pos, H, H, 0);
        Dist < MinDist ->
            find_closest(T, Pos, H, H, Dist);
        Dist == MinDist andalso H < BestIndex ->
            find_closest(T, Pos, H, H, Dist);
        true ->
            find_closest(T, Pos, BestIndex, H, MinDist)
    end.