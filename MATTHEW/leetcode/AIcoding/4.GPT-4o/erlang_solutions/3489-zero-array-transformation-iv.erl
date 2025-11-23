-module(solution).
-export([can_transform/1]).

can_transform(Nums) ->
    Sum = lists:sum(Nums),
    ZeroCount = lists:length(lists:filter(fun(X) -> X =:= 0 end, Nums)),
    (Sum rem 2 =:= 0) orelse (ZeroCount > 0).