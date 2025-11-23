-module(solution).
-export([least_ops_express_target/2]).

least_ops_express_target(X, Target) ->
    solve(X, Target, #{}).

solve(X, Target, Memo) ->
    case maps:find(Target, Memo) of
        {ok, Res} ->
            Res;
        error ->
            Res = if
                Target == 1 ->
                    1;
                X == Target ->
                    0;
                X > Target ->
                    min(2 * Target - 1, 2 * (X - Target));
                true ->
                    K = 0,
                    Product = 1,
                    {NewK, NewProduct} = find_k(X, Target, K, Product),
                    Option1 = NewK + solve(X, Target - NewProduct div X, Memo),
                    Option2 = if
                        NewProduct == Target -> Option1;
                        true -> NewK + 1 + solve(X, NewProduct - Target, Memo)
                    end,
                    min(Option1, Option2)
            end,
            solve(X, Target, maps:put(Target, Res, Memo))
    end.

find_k(X, Target, K, Product) ->
    if
        Product * X > Target ->
            {K, Product};
        true ->
            find_k(X, Target, K + 1, Product * X)
    end.