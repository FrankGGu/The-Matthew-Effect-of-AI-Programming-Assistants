-module(solution).
-export([min_number_of_booths/1]).

min_number_of_booths(Events) ->
    {Starts, Ends} = lists:unzip(Events),
    StartList = lists:sort(Starts),
    EndList = lists:sort(Ends),
    min_number_of_booths(StartList, EndList, 0, 0, 0).

min_number_of_booths([], _, _, _, Count) ->
    Count;
min_number_of_booths(_, [], _, _, Count) ->
    Count;
min_number_of_booths([S | ST], [E | ET], I, J, Count) ->
    if
        S < E ->
            min_number_of_booths(ST, EndList, I + 1, J, Count + 1);
        true ->
            min_number_of_booths([S | ST], ET, I, J + 1, Count)
    end.