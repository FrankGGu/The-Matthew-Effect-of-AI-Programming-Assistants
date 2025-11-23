-module(solution).
-export([critical_connections/2]).

critical_connections(N, Connections) ->
    Graph = build_graph(N, Connections),
    {Low, Disc, Parent} = initialize(N),
    {Result, _, _, _} = tarjan(0, 0, Graph, Low, Disc, Parent, []),
    Result.

build_graph(N, Connections) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = setelement(U + 1, Acc, [V | element(U + 1, Acc)]),
        setelement(V + 1, Acc1, [U | element(V + 1, Acc1)])
    end, Graph, Connections).

initialize(N) ->
    Low = array:new(N, {default, 0}),
    Disc = array:new(N, {default, -1}),
    Parent = array:new(N, {default, -1}),
    {Low, Disc, Parent}.

tarjan(Time, U, Graph, Low, Disc, Parent, Result) ->
    case array:get(U, Disc) of
        -1 ->
            Disc1 = array:set(U, Time, Disc),
            Low1 = array:set(U, Time, Low),
            {Result1, Time1, Low2, Disc2, Parent1} = dfs(Time + 1, U, Graph, Low1, Disc1, Parent, Result),
            {Result1, Time1, Low2, Disc2, Parent1};
        _ ->
            {Result, Time, Low, Disc, Parent}
    end.

dfs(Time, U, Graph, Low, Disc, Parent, Result) ->
    lists:foldl(fun(V, {Res, T, L, D, P}) ->
        case array:get(V, D) of
            -1 ->
                P1 = array:set(V, U, P),
                {Res1, T1, L1, D1, P2} = dfs(T + 1, V, Graph, L, D, P1, Res),
                L2 = array:set(U, min(array:get(U, L1), array:get(V, L1), L1),
                case array:get(U, L1) > array:get(V, D1) of
                    true ->
                        {[[U, V] | Res1], T1, L2, D1, P2};
                    false ->
                        {Res1, T1, L2, D1, P2}
                end;
            _ ->
                case V =/= array:get(U, P) of
                    true ->
                        L1 = array:set(U, min(array:get(U, L), array:get(V, D)), L),
                        {Res, T, L1, D, P};
                    false ->
                        {Res, T, L, D, P}
                end
        end
    end, {Result, Time, Low, Disc, Parent}, element(U + 1, Graph)).

min(A, B) when A < B -> A;
min(_, B) -> B.