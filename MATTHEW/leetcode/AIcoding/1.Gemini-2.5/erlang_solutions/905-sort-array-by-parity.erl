-module(solution).
-export([sort_array_by_parity/1]).

sort_array_by_parity(A) ->
    {Evens, Odds} = lists:foldl(
        fun(X, {EvensAcc, OddsAcc}) ->
            if
                X rem 2 == 0 -> {[X | EvensAcc], OddsAcc};
                true -> {EvensAcc, [X | OddsAcc]}
            end
        end,
        {[], []},
        A
    ),
    Evens ++ Odds.