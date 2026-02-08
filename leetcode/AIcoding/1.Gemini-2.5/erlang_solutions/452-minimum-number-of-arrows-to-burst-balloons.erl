-module(solution).
-export([findMinArrowShots/1]).

findMinArrowShots(Points) ->
    case Points of
        [] -> 0;
        _ ->
            SortedPoints = lists:sort(fun(A, B) -> element(2, A) =< element(2, B) end, Points),
            FirstBalloon = hd(SortedPoints),
            InitialArrows = 1,
            InitialCurrentEnd = element(2, FirstBalloon),

            {FinalArrows, _} = lists:foldl(
                fun(Balloon, {Arrows, CurrentEnd}) ->
                    Start = element(1, Balloon),
                    End = element(2, Balloon),
                    if Start > CurrentEnd ->
                        {Arrows + 1, End};
                    true ->
                        {Arrows, min(CurrentEnd, End)}
                    end
                end,
                {InitialArrows, InitialCurrentEnd},
                tl(SortedPoints)
            ),
            FinalArrows
    end.