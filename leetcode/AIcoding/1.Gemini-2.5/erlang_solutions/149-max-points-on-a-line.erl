-module(solution).
-export([maxPoints/1]).

gcd(A, 0) -> abs(A);
gcd(0, B) -> abs(B);
gcd(A, B) -> gcd(B, A rem B).

maxPoints(Points) ->
    Len = length(Points),
    if
        Len =< 2 -> Len;
        true ->
            max_points_loop(Points, 0)
    end.

max_points_loop([], MaxOverall) -> MaxOverall;
max_points_loop([P1 | Rest], CurrentMaxOverall) ->
    X1 = hd(P1),
    Y1 = hd(tl(P1)),

    InitialState = {#{}, 0, 0}, % {Slopes, Duplicates, CurrentMaxForP1}

    {FinalSlopes, FinalDuplicates, FinalCurrentMaxForP1} =
        lists:foldl(
            fun(P2, {AccSlopes, AccDuplicates, AccCurrentMaxForP1}) ->
                X2 = hd(P2),
                Y2 = hd(tl(P2)),

                if
                    X1 == X2 andalso Y1 == Y2 ->
                        {AccSlopes, AccDuplicates + 1, AccCurrentMaxForP1};
                    true ->
                        DeltaX = X2 - X1,
                        DeltaY = Y2 - Y1,

                        SlopeKey =
                            if
                                DeltaX == 0 -> vertical;
                                DeltaY == 0 -> horizontal;
                                true ->
                                    {NormDeltaY, NormDeltaX} =
                                        if
                                            DeltaX < 0 -> {-DeltaY, -DeltaX};
                                            true -> {DeltaY, DeltaX}
                                        end,
                                    CommonDivisor = gcd(abs(NormDeltaY), abs(NormDeltaX)),
                                    {NormDeltaY div CommonDivisor, NormDeltaX div CommonDivisor}
                            end,

                        NewCount = maps:get(SlopeKey, AccSlopes, 0) + 1,
                        NewSlopes = maps:put(SlopeKey, NewCount, AccSlopes),
                        NewCurrentMaxForP1 = max(AccCurrentMaxForP1, NewCount),
                        {NewSlopes, AccDuplicates, NewCurrentMaxForP1}
                end
            end,
            InitialState,
            Rest
        ),

    MaxPointsIncludingP1 = FinalCurrentMaxForP1 + FinalDuplicates + 1,
    NewMaxOverall = max(CurrentMaxOverall, MaxPointsIncludingP1),

    max_points_loop(Rest, NewMaxOverall).