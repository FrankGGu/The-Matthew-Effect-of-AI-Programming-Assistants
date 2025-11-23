-module(solution).
-export([find_musicians/1]).

find_musicians(Positions) ->
    find_musicians(Positions, 1, []).

find_musicians([], _, Result) ->
    lists:reverse(Result);
find_musicians([H | T], N, Result) ->
    case H of
        0 -> find_musicians(T, N, [N | Result]);
        _ -> find_musicians(T, N + 1, Result)
    end.