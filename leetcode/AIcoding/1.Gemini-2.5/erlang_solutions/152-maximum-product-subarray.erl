-module(solution).
-export([max_product/1]).

max_product([H|T]) ->
    {_FinalMaxP, _FinalMinP, OverallMax} = lists:foldl(
        fun(Num, {MaxP, MinP, OverallMax}) ->
            Prod1 = MaxP * Num,
            Prod2 = MinP * Num,
            NewMaxP = erlang:max(Num, erlang:max(Prod1, Prod2)),
            NewMinP = erlang:min(Num, erlang:min(Prod1, Prod2)),
            NewOverallMax = erlang:max(OverallMax, NewMaxP),
            {NewMaxP, NewMinP, NewOverallMax}
        end,
        {H, H, H},
        T
    ),
    OverallMax.