-module(solution).
-export([distance_traveled/2]).

-spec distance_traveled(MainTank :: integer(), AdditionalTank :: integer()) -> integer().
distance_traveled(MainTank, AdditionalTank) ->
    travel(MainTank, AdditionalTank, 0).

travel(M, A, D) ->
    NeededToReach10 = 10 - M,
    {CurrentM, CurrentA} =
        if NeededToReach10 > 0 andalso A > 0 ->
            TransferAmount = min(NeededToReach10, A),
            {M + TransferAmount, A - TransferAmount};
        true ->
            {M, A}
        end,

    if CurrentM >= 10 ->
        NewD = D + 10,
        M_after_travel = CurrentM - 10,
        {NextM, NextA} =
            if CurrentA >= 1 ->
                {M_after_travel + 1, CurrentA - 1};
            true ->
                {M_after_travel, CurrentA}
            end,
        travel(NextM, NextA, NewD);
    true ->
        D
    end.