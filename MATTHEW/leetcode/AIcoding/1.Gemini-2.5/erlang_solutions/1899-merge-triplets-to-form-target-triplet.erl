-module(solution).
-export([mergeTriplets/2]).

mergeTriplets(Triplets, Target) ->
    [Tx, Ty, Tz] = Target,
    {FoundX, FoundY, FoundZ} = lists:foldl(
        fun([A, B, C], {AccX, AccY, AccZ}) ->
            if
                A =< Tx andalso B =< Ty andalso C =< Tz ->
                    {AccX orelse (A == Tx),
                     AccY orelse (B == Ty),
                     AccZ orelse (C == Tz)};
                true ->
                    {AccX, AccY, AccZ}
            end
        end,
        {false, false, false},
        Triplets
    ),
    FoundX andalso FoundY andalso FoundZ.