-module(solution).
-export([min_difference/2]).

min_difference(Nums, Queries) ->
    Prefix = build_prefix(Nums),
    lists:map(fun({L, R}) -> query(Prefix, L, R) end, Queries).

build_prefix(Nums) ->
    lists:foldl(fun(Num, Acc) ->
        Last = case Acc of
            [] -> lists:duplicate(101, 0);
            [H|_] -> H
        end,
        New = lists:zipwith(fun(X, Y) -> X + Y end, Last, 
                             lists:duplicate(Num, 1) ++ lists:duplicate(101 - Num, 0)),
        [New | Acc]
    end, [], Nums).

query(Prefix, L, R) ->
    Left = case length(Prefix) - L - 1 of
        Pos when Pos >= 0 -> lists:nth(Pos + 1, Prefix);
        _ -> lists:duplicate(101, 0)
    end,
    Right = case length(Prefix) - R - 1 of
        Pos when Pos >= 0 -> lists:nth(Pos + 1, Prefix);
        _ -> lists:duplicate(101, 0)
    end,
    Freq = lists:zipwith(fun(X, Y) -> X - Y end, Right, Left),
    Present = [I || {I, C} <- lists:zip(lists:seq(1, 101), Freq), C > 0],
    case Present of
        [] -> -1;
        _ ->
            lists:min([B - A || {A, B} <- lists:zip(Present, tl(Present))])
    end.