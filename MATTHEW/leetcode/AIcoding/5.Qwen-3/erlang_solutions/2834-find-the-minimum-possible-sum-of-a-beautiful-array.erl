-module(solution).
-export([find_min_sum/1]).

find_min_sum(N) ->
    find_min_sum(N, 1, 0, []).

find_min_sum(0, _, _, Acc) ->
    lists:sum(Acc);
find_min_sum(N, Start, Sum, Acc) ->
    Next = Start + 1,
    case is_beautiful(Acc, Start) of
        true ->
            find_min_sum(N - 1, Next, Sum + Start, [Start | Acc]);
        false ->
            find_min_sum(N, Next, Sum, Acc)
    end.

is_beautiful([], _) ->
    true;
is_beautiful([H | T], Num) ->
    case (Num rem H == 0) or (H rem Num == 0) of
        true -> is_beautiful(T, Num);
        false -> false
    end.