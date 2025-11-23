-module(solution).
-export([number_of_full_rounds/2]).

number_of_full_rounds(Start, End) ->
    {S_H, S_M} = parse_time(Start),
    {E_H, E_M} = parse_time(End),
    StartMin = S_H * 60 + S_M,
    EndMin = E_H * 60 + E_M,
    if
        EndMin < StartMin ->
            EndMin + 24 * 60 - StartMin;
        true ->
            EndMin - StartMin
    end.

parse_time(Time) ->
    [H, M] = string:split(Time, ":"),
    {list_to_integer(H), list_to_integer(M)}.