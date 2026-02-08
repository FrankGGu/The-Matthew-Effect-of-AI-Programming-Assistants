-module(solution).
-export([closest/2]).

closest(Target, Integers) ->
    Min = lists:foldl(fun(I, Acc) -> min(Acc, abs(I - Target)) end, 16#7FFFFFFF, Integers),
    Min.