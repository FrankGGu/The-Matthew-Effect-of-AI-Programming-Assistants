-module(solution).
-export([subarray_roots/1]).

subarray_roots(Nums) ->
    Result = sets:new(),
    Length = length(Nums),
    lists:foreach(fun(I) ->
        Current = 0,
        lists:foreach(fun(J) ->
            Current = Current bor element(J + 1, Nums),
            sets:add_element(Current, Result)
        end, lists:seq(I, Length - 1))
    end, lists:seq(0, Length - 1)),
    sets:to_list(Result).