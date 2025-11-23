-module(guard_castle).
-export([guard_castle/1]).

guard_castle(Gates) ->
    guard_castle(Gates, 0, 0).

guard_castle([], _, Result) ->
    Result;
guard_castle([H|T], Index, Result) ->
    case H of
        0 -> guard_castle(T, Index + 1, Result);
        _ -> guard_castle(T, Index + 1, Result + H)
    end.