-module(minimum_space_wasted).
-export([minimum_space_wasted/2]).

minimum_space_wasted(Packages, Boxes) ->
    lists:sort(Packages) -> SortedPackages,
    MinWasted = fold(SortedPackages, Boxes, infinity),
    case MinWasted of
        infinity -> -1;
        Wasted -> Wasted rem (1000000000 + 7)
    end.

fold(_, [], Acc) ->
    Acc;
fold(Packages, [Box | Rest], Acc) ->
    lists:sort(Box) -> SortedBox,
    case can_fit(Packages, SortedBox) of
        true ->
            Wasted = waste(Packages, SortedBox),
            NewAcc = min(Acc, Wasted),
            fold(Packages, Rest, NewAcc);
        false ->
            fold(Packages, Rest, Acc)
    end.

can_fit(Packages, Box) ->
    MaxPackage = lists:last(Packages),
    MinBox = lists:nth(1, Box),
    MaxBox = lists:last(Box),
    MaxPackage =< MaxBox andalso MinBox =< lists:nth(1,Packages).

waste(Packages, Box) ->
    Sum = lists:sum(Packages),
    MaxPackage = lists:last(Packages),
    MinBox = lists:nth(1, Box),
    MaxBox = lists:last(Box),

    case MaxPackage =< MaxBox andalso MinBox =< lists:nth(1,Packages) of
        true -> MaxBox * length(Packages) - Sum;
        false -> infinity
    end.