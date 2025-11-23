-module(solution).
-export([earliest_and_latest/3]).

earliest_and_latest/N, X, Y) ->
    Players = lists:seq(1, N),
    Matches = round_matches(Players),
    {Earliest, Latest} = rounds(X, Y, Matches, 1, N),
    {Earliest, Latest}.

round_matches(Players) ->
    lists:map(fun({A, B}) -> {A, B} end, lists:zip(Players, tl(Players))).

rounds(X, Y, Matches, Round, Total) ->
    case Matches of
        [] -> {infinity, -infinity};
        [{A, B} | Rest] ->
            case {A, B} of
                {X, Y} -> {Round, Round};
                _ -> rounds(X, Y, Rest, Round + 1, Total)
            end
    end.