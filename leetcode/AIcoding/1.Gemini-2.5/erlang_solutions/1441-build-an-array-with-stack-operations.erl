-module(solution).
-export([build_array/2]).

-spec build_array(Target :: [integer()], N :: integer()) -> [string()].
build_array(Target, _N) ->
    build_array_recursive(1, Target, []).

build_array_recursive(_CurrentNum, [], AccOps) ->
    lists:reverse(AccOps);
build_array_recursive(CurrentNum, [H | T], AccOps) when CurrentNum == H ->
    build_array_recursive(CurrentNum + 1, T, ["Push" | AccOps]);
build_array_recursive(CurrentNum, [H | T], AccOps) when CurrentNum < H ->
    build_array_recursive(CurrentNum + 1, [H | T], ["Pop", "Push" | AccOps]).