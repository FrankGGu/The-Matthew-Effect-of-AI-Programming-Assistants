-module(solution).
-export([sum_even_after_queries/2]).

sum_even_after_queries(Nums, Queries) ->
    sum_even_after_queries(Nums, Queries, 0).

sum_even_after_queries([], [], Acc) ->
    Acc;
sum_even_after_queries([H | T], [Q | Qs], Acc) ->
    {Val, Index} = Q,
    Old = lists:nth(Index + 1, Nums),
    New = Old + Val,
    case Old rem 2 of
        0 -> Acc = Acc - Old;
        _ -> Acc
    end,
    case New rem 2 of
        0 -> Acc = Acc + New;
        _ -> Acc
    end,
    sum_even_after_queries(T, Qs, Acc).

sum_even_after_queries(_, _, _) ->
    0.