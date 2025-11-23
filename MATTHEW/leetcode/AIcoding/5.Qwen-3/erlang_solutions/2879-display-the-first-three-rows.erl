-module(display_first_three_rows).
-export([run/0]).

run() ->
    Data = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]],
    FirstThree = lists:sublist(Data, 3),
    io:format("~p~n", [FirstThree]).