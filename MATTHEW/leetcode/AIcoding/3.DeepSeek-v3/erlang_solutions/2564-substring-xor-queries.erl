-module(solution).
-export([substring_xor_queries/2]).

substring_xor_queries(S, Queries) ->
    N = length(S),
    Prefix = array:new([{size, N + 1}, {default, 0}]),
    Prefix1 = lists:foldl(fun(I, Acc) ->
        Val = array:get(I, Acc) * 2 + (lists:nth(I + 1, S) - $0),
        array:set(I + 1, Val, Acc)
    end, Prefix, lists:seq(0, N - 1)),
    Map = build_map(S, Prefix1, 0, N, #{}),
    process_queries(Queries, Map).

build_map(S, Prefix, I, N, Map) when I < N ->
    Map1 = build_map_inner(S, Prefix, I, I + 1, min(N, I + 30), Map),
    build_map(S, Prefix, I + 1, N, Map1);
build_map(_S, _Prefix, _I, _N, Map) ->
    Map.

build_map_inner(S, Prefix, I, J, N, Map) when J =< N ->
    Len = J - I,
    Sub = lists:sublist(S, I + 1, Len),
    Num = array:get(J, Prefix) - array:get(I, Prefix) * (1 bsl Len),
    Map1 = case maps:find(Num, Map) of
        {ok, {L, _}} when L =< Len -> Map;
        _ -> maps:put(Num, {I, J - 1}, Map)
    end,
    build_map_inner(S, Prefix, I, J + 1, N, Map1);
build_map_inner(_S, _Prefix, _I, _J, _N, Map) ->
    Map.

process_queries([], _Map) -> [];
process_queries([{A, B} | Rest], Map) ->
    Target = A bxor B,
    case maps:find(Target, Map) of
        {ok, {L, R}} -> [{L, R} | process_queries(Rest, Map)];
        error -> [{-1, -1} | process_queries(Rest, Map)]
    end.