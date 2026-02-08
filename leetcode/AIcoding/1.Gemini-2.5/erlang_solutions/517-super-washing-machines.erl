-module(solution).
-export([super_washing_machines/1]).

super_washing_machines(Machines) ->
    N = length(Machines),
    Sum = lists:sum(Machines),

    case Sum rem N of
        0 ->
            Avg = Sum div N,
            {MaxMoves, _CurrentBalance} = lists:foldl(
                fun(Dresses, {AccMaxMoves, AccBalance}) ->
                    Diff = Dresses - Avg,
                    NewBalance = AccBalance + Diff,

                    MaxFromDiff = erlang:max(0, Diff),
                    MaxFromBalance = erlang:abs(NewBalance),

                    CurrentMax = erlang:max(MaxFromDiff, MaxFromBalance),
                    NewMaxMoves = erlang:max(AccMaxMoves, CurrentMax),

                    {NewMaxMoves, NewBalance}
                end,
                {0, 0},
                Machines
            ),
            MaxMoves;
        _ ->
            -1
    end.