-module(solution).
-export([ship_within_days/2]).

ship_within_days(Packages, D) ->
    MaxPackage = lists:max(Packages),
    TotalWeight = lists:sum(Packages),

    BinarySearch = fun F(Low, High, Ans) ->
        if
            Low > High -> Ans;
            true ->
                Mid = Low + (High - Low) div 2,
                if
                    can_ship(Packages, Mid, D) ->
                        F(Low, Mid - 1, Mid);
                    true ->
                        F(Mid + 1, High, Ans)
                end
        end
    end,

    BinarySearch(MaxPackage, TotalWeight, TotalWeight).

can_ship(Packages, Capacity, D) ->
    can_ship_loop(Packages, Capacity, D, 1, 0).

can_ship_loop([], _Capacity, D, DaysNeeded, _CurrentWeight) ->
    DaysNeeded =< D;
can_ship_loop([H|T], Capacity, D, DaysNeeded, CurrentWeight) ->
    if
        DaysNeeded > D -> false;
        CurrentWeight + H =< Capacity ->
            can_ship_loop(T, Capacity, D, DaysNeeded, CurrentWeight + H);
        true ->
            can_ship_loop(T, Capacity, D, DaysNeeded + 1, H)
    end.