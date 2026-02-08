-module(solution).
-export([permutationDifference/2]).

permutationDifference(S, T) ->
    S_Map = build_index_map(S),
    calculate_difference(T, S_Map).

build_index_map(S) ->
    build_index_map(S, 0, #{}).

build_index_map([], _Idx, AccMap) -> AccMap;
build_index_map([H|T], Idx, AccMap) ->
    build_index_map(T, Idx + 1, maps:put(H, Idx, AccMap)).

calculate_difference(T, S_Map) ->
    calculate_difference(T, S_Map, 0, 0).

calculate_difference([], _S_Map, _T_Idx, AccDiff) -> AccDiff;
calculate_difference([H|T_Rest], S_Map, T_Idx, AccDiff) ->
    S_Idx = maps:get(H, S_Map),
    Diff = abs(S_Idx - T_Idx),
    calculate_difference(T_Rest, S_Map, T_Idx + 1, AccDiff + Diff).