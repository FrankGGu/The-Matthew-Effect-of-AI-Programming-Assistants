-module(solution).
-export([solve/2]).

solve(Nums, Queries) ->
    NumArray = array:from_list(Nums),
    lists:map(fun([Idx1, Idx2]) ->
                  Num1 = array:get(Idx1, NumArray),
                  Num2 = array:get(Idx2, NumArray),
                  math:gcd(Num1, Num2)
              end, Queries).