-module(solution).
-export([nextGreaterElement/2]).

nextGreaterElement(Nums1, Nums2) ->
    NgeMap = build_nge_map(Nums2),
    lists:map(fun(N) -> maps:get(N, NgeMap) end, Nums1).

build_nge_map(Nums2) ->
    build_nge_map_recursive(Nums2, [], #{}).

build_nge_map_recursive([], Stack, Map) ->
    lists:foldl(fun(N, AccMap) -> maps:put(N, -1, AccMap) end, Map, Stack);
build_nge_map_recursive([H|T], Stack, Map) ->
    {NewStack, UpdatedMap} = pop_smaller(H, Stack, Map),
    build_nge_map_recursive(T, [H|NewStack], UpdatedMap).

pop_smaller(CurrentNum, [StackHead|StackTail], Map) when StackHead < CurrentNum ->
    NewMap = maps:put(StackHead, CurrentNum, Map),
    pop_smaller(CurrentNum, StackTail, NewMap);
pop_smaller(_CurrentNum, Stack, Map) ->
    {Stack, Map}.