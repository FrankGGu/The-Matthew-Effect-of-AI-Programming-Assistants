-module(solution).
-export([build_array/2]).

build_array(Nums, target) ->
    build_array(Nums, target, []).

build_array([], _, Acc) ->
    lists:reverse(Acc);
build_array([H | T], Target, Acc) ->
    if
        H == hd(Target) ->
            build_array(T, tl(Target), ["Push" | Acc]);
        true ->
            build_array(T, Target, Acc)
    end.