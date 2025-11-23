-module(solution).
-export([solve/1]).

solve(S) when is_list(S) ->
    check_consecutive(S).

check_consecutive([]) ->
    0;
check_consecutive([_]) ->
    0;
check_consecutive([H1, H2 | T]) ->
    case H1 == H2 of
        true ->
            2;
        false ->
            check_consecutive([H2|T])
    end.