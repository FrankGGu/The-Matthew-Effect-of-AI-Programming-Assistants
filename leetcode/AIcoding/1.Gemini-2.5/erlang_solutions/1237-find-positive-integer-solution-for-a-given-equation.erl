-module(solution).
-export([findSolution/2]).

-define(MAX_XY, 1000).

findSolution(CustomFun, Z) ->
    findSolution_recursive(CustomFun, Z, 1, ?MAX_XY, []).

findSolution_recursive(_CustomFun, _Z, X, _Y, Acc) when X > ?MAX_XY ->
    lists:reverse(Acc);
findSolution_recursive(_CustomFun, _Z, _X, Y, Acc) when Y < 1 ->
    lists:reverse(Acc);
findSolution_recursive(CustomFun, Z, X, Y, Acc) ->
    Val = CustomFun(X, Y),
    if
        Val == Z ->
            findSolution_recursive(CustomFun, Z, X + 1, Y - 1, [[X, Y] | Acc]);
        Val < Z ->
            findSolution_recursive(CustomFun, Z, X + 1, Y, Acc);
        Val > Z ->
            findSolution_recursive(CustomFun, Z, X, Y - 1, Acc)
    end.