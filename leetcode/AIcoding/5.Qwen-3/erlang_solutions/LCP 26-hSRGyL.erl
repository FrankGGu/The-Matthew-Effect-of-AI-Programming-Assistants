-module(navigation_device).
-export([solve/1]).

solve(Input) ->
    [N, M | Rest] = string:tokens(Input, " "),
    NInt = list_to_integer(N),
    MInt = list_to_integer(M),
    Grid = lists:sublist(Rest, NInt * MInt),
    solve(Grid, NInt, MInt, 0, 0, []).

solve([], _, _, _, _, Acc) ->
    lists:reverse(Acc);
solve([H | T], N, M, Row, Col, Acc) ->
    case H of
        $* -> 
            solve(T, N, M, Row, Col + 1, [[Row, Col] | Acc]);
        _ -> 
            solve(T, N, M, Row, Col + 1, Acc)
    end.