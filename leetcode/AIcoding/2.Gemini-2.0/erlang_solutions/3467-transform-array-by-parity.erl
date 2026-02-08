-module(transform_array_by_parity).
-export([sort_array_by_parity/1]).

sort_array_by_parity(A) ->
    lists:foldl(
        fun(X, {Evens, Odds}) ->
            case X rem 2 of
                0 -> {[X | Evens], Odds};
                _ -> {Evens, [X | Odds]}
            end
        end,
        {[], []},
        A
    )
    |> fun({Evens, Odds}) -> lists:reverse(Evens) ++ lists:reverse(Odds) end.