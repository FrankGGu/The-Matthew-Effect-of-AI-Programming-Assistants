-module(solution).
-export([four_sum_count/4]).

four_sum_count(A, B, C, D) ->
    Map = build_map(A, B),
    count(C, D, Map, 0).

build_map([], _) -> #{};
build_map([H1|T1], [H2|T2]) ->
    Key = H1 + H2,
    Map = build_map(T1, T2),
    maps:update_with(Key, fun(V) -> V + 1 end, 1, Map).

count([], _, _, Acc) -> Acc;
count([H|T], D, Map, Acc) ->
    Sum = -H,
    Count = maps:get(Sum, Map, 0),
    count(T, D, Map, Acc + Count).