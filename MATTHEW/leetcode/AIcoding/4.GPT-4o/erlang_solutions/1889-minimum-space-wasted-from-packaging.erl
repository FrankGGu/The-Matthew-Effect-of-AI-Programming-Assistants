-module(solution).
-export([min_space_wasted_from_packaging/2]).

min_space_wasted_from_packaging(Sizes, Boxes) ->
    SizesSorted = lists:sort(Sizes),
    BoxesSorted = lists:sort(Boxes),
    min_space_wasted(SizesSorted, BoxesSorted, 0, 0).

min_space_wasted([], _, Acc, _) -> Acc;
min_space_wasted(Sizes, Boxes, Acc, BoxIndex) ->
    case lists:splitwith(fun(X) -> X =< lists:nth(BoxIndex + 1, Boxes) end, Sizes) of
        {Fitting, Remaining} ->
            NewAcc = Acc + lists:sum(Fitting) + (lists:nth(BoxIndex + 1, Boxes) - lists:length(Fitting) * lists:nth(BoxIndex + 1, Boxes)),
            min_space_wasted(Remaining, Boxes, NewAcc, BoxIndex + 1)
    end.