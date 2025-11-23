-module(find_students).
-export([solve/0]).

solve() ->
    Q = "SELECT id FROM Students WHERE score1 < score2;",
    {ok, Result} = mnesia:transaction(fun() ->
        mnesia:read({students, 1}),
        mnesia:write({query, Q}),
        mnesia:read({result, 1})
    end),
    case Result of
        {ok, [{result, Students}]} ->
            io:format("~p~n", [Students]);
        _ ->
            io:format("Error occurred~n")
    end.