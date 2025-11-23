-module(solution).
-export([getMinDistSum/1]).

calculate_total_distance(X, Y, Points) ->
    lists:foldl(fun([Px, Py], Acc) ->
        Dist = math:sqrt(math:pow(X - Px, 2) + math:pow(Y - Py, 2)),
        Acc + Dist
    end, 0.0, Points).

getMinDistSum(Points) ->
    case length(Points) of
        0 -> 0.0;
        _ ->
            {InitialX, InitialY} = lists:foldl(fun([Px, Py], {SumX, SumY}) ->
                {SumX + Px, SumY + Py}
            end, {0.0, 0.0}, Points),
            NumPoints = length(Points),
            CurrentX = InitialX / NumPoints,
            CurrentY = InitialY / NumPoints,

            InitialStep = 10.0,
            Epsilon = 1.0e-7,

            solve_iter(CurrentX, CurrentY, InitialStep, Epsilon, Points)
    end.

solve_iter(CurrentX, CurrentY, Step, Epsilon, Points) ->
    if
        Step < Epsilon ->
            calculate_total_distance(CurrentX, CurrentY, Points);
        true ->
            MaxItersPerStep = 150,
            {NextX, NextY, _Improved} =
                iterate_for_step(CurrentX, CurrentY, Step, Points, 0, MaxItersPerStep),

            NewStep = Step / 10.0,
            solve_iter(NextX, NextY, NewStep, Epsilon, Points)
    end.

iterate_for_step(CurrentX, CurrentY, Step, Points, IterCount, MaxIters) ->
    if
        IterCount >= MaxIters ->
            {CurrentX, CurrentY, false};
        true ->
            CurrentMinDist = calculate_total_distance(CurrentX, CurrentY, Points),
            Directions = [
                {CurrentX + Step, CurrentY},
                {CurrentX - Step, CurrentY},
                {CurrentX, CurrentY + Step},
                {CurrentX, CurrentY - Step},
                {CurrentX + Step, CurrentY + Step},
                {CurrentX + Step, CurrentY - Step},
                {CurrentX - Step, CurrentY + Step},
                {CurrentX - Step, CurrentY - Step}
            ],

            {BestX, BestY, BestDist, Improved} = lists:foldl(
                fun({NX, NY}, {AccX, AccY, AccDist, AccImproved}) ->
                    NewDist = calculate_total_distance(NX, NY, Points),
                    if
                        NewDist < AccDist ->
                            {NX, NY, NewDist, true};
                        true ->
                            {AccX, AccY, AccDist, AccImproved}
                    end
                end, {CurrentX, CurrentY, CurrentMinDist, false}, Directions
            ),

            if
                Improved ->
                    iterate_for_step(BestX, BestY, Step, Points, IterCount + 1, MaxIters);
                true ->
                    {CurrentX, CurrentY, false}
            end
    end.