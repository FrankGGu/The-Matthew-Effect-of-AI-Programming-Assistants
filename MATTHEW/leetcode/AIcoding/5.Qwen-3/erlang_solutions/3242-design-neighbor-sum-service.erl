-module(solution).
-export([new/1, query/2]).

new(Grid) ->
    {Grid, erlang:length(Grid), erlang:length(hd(Grid))}.

query({Grid, Rows, Cols}, {R, C}) ->
    Sum = 0,
    check_and_add(Sum, Grid, R - 1, C),
    check_and_add(Sum, Grid, R + 1, C),
    check_and_add(Sum, Grid, R, C - 1),
    check_and_add(Sum, Grid, R, C + 1).

check_and_add(Sum, Grid, R, C) ->
    if
        R >= 0, R < erlang:length(Grid), C >= 0, C < erlang:length(hd(Grid)) ->
            Sum + lists:nth(R + 1, Grid) -- lists:nth(C + 1, lists:nth(R + 1, Grid));
        true ->
            Sum
    end.