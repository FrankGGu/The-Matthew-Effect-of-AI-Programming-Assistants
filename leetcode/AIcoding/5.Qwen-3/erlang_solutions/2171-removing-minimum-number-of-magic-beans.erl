-module(solution).
-export([minimum_remaining_beans/1]).

minimum_remaining_beans(Beans) ->
    Sorted = lists:sort(Beans),
    N = length(Sorted),
    Total = lists:sum(Sorted),
    minimum_remaining_beans(Sorted, N, 0, Total).

minimum_remaining_beans([], _, _, _) ->
    0;
minimum_remaining_beans([B | Rest], N, I, Total) ->
    Current = B * (N - I),
    Next = minimum_remaining_beans(Rest, N, I + 1, Total),
    max(Current, Next).