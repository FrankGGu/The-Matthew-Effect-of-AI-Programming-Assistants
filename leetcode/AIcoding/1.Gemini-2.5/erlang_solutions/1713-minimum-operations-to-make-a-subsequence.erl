-module(solution).
-export([min_operations/2]).

min_operations(Target, Arr) ->
    TargetMap = build_target_map(Target),
    MappedArr = filter_and_map_arr(Arr, TargetMap),
    LisLength = lis(MappedArr),
    length(Target) - LisLength.

build_target_map(Target) ->
    build_target_map_recursive(Target, 0, maps:new()).

build_target_map_recursive([], _Idx, Map) -> Map;
build_target_map_recursive([H|T], Idx, Map) ->
    build_target_map_recursive(T, Idx + 1, maps:put(H, Idx, Map)).

filter_and_map_arr(Arr, TargetMap) ->
    filter_and_map_arr_recursive(Arr, TargetMap, []).

filter_and_map_arr_recursive([], _TargetMap, Acc) -> lists:reverse(Acc);
filter_and_map_arr_recursive([H|T], TargetMap, Acc) ->
    case maps:find(H, TargetMap) of
        {ok, Idx} -> filter_and_map_arr_recursive(T, TargetMap, [Idx|Acc]);
        _ -> filter_and_map_arr_recursive(T, TargetMap, Acc)
    end.

lis(Nums) ->
    lis_recursive(Nums, gb_trees:empty()).

lis_recursive([], TailsTree) -> gb_trees:size(TailsTree);
lis_recursive([N|Rest], TailsTree) ->
    case gb_trees:lookup_ge_key(N, TailsTree) of
        {value, K, _V} ->
            NewTailsTree = gb_trees:delete(K, TailsTree),
            lis_recursive(Rest, gb_trees:insert(N, N, NewTailsTree));
        none ->
            lis_recursive(Rest, gb_trees:insert(N, N, TailsTree))
    end.