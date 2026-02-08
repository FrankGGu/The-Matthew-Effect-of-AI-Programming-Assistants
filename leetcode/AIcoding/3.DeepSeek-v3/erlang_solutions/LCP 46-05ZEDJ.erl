-module(solution).
-export([volunteer_deployment/2]).

volunteer_deployment(FinalCount, Edges) ->
    N = length(FinalCount),
    Adj = lists:foldl(fun({U, V}, Acc) ->
        lists:keyreplace(U, 1, Acc, {U, [V | element(2, lists:keyfind(U, 1, Acc))]}),
        lists:keyreplace(V, 1, Acc, {V, [U | element(2, lists:keyfind(V, 1, Acc))]})
    end, [{I, []} || I <- lists:seq(0, N)], Edges),
    {A, B} = solve(0, -1, Adj, FinalCount),
    X = (lists:nth(1, FinalCount) - lists:nth(1, B)) div (lists:nth(1, A) - lists:nth(1, B)),
    [A0 * X + B0 || {A0, B0} <- lists:zip(A, B)].

solve(U, Parent, Adj, FinalCount) ->
    Children = [V || V <- element(2, lists:keyfind(U, 1, Adj)), V =/= Parent],
    {A, B} = lists:foldl(fun(V, {AccA, AccB}) ->
        {CA, CB} = solve(V, U, Adj, FinalCount),
        {[ -C || C <- CA] ++ AccA, [FinalCountV - C || {FinalCountV, C} <- lists:zip(lists:nth(V+1, FinalCount), CB)] ++ AccB}
    end, {[1], [0]}, Children),
    {A, B}.