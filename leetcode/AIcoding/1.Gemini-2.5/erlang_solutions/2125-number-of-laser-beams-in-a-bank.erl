-module(solution).
-export([number_of_laser_beams/1]).

number_of_laser_beams(Bank) ->
    solve_acc(Bank, 0, 0).

solve_acc([], TotalBeams, _PrevRowDevices) ->
    TotalBeams;
solve_acc([Row | Rest], TotalBeams, PrevRowDevices) ->
    CurrentRowDevices = count_ones(Row),
    if CurrentRowDevices > 0 ->
        NewTotalBeams = TotalBeams + (PrevRowDevices * CurrentRowDevices),
        NewPrevRowDevices = CurrentRowDevices,
        solve_acc(Rest, NewTotalBeams, NewPrevRowDevices);
    true ->
        solve_acc(Rest, TotalBeams, PrevRowDevices)
    end.

count_ones(RowString) ->
    length(lists:filter(fun(C) -> C == $1 end, RowString)).