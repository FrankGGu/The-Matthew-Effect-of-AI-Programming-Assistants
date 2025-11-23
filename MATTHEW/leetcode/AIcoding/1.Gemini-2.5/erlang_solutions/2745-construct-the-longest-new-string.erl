-module(solution).
-export([longest_string/3]).

-spec longest_string(X :: integer(), Y :: integer(), Z :: integer()) -> integer().
longest_string(X, Y, Z) ->
    MinXY = min(X, Y),
    Additional = if X =/= Y -> 1;
                    true -> 0
                 end,
    (MinXY * 2) + (Z * 2) + Additional.