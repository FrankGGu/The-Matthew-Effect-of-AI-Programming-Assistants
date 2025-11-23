-module(solution).
-export([can_transform/1]).

can_transform(Array) ->
    Sum = lists:sum(Array),
    Length = length(Array),
    Sum rem Length =:= 0.