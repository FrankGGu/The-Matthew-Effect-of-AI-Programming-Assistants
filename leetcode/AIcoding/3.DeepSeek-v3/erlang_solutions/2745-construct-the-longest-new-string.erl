-module(solution).
-export([longest_string/3]).

longest_string(X, Y, Z) ->
    case abs(X - Y) of
        Diff when Diff =< 1 -> (X + Y + Z) * 2;
        Diff when X > Y -> (Y * 2 + 1 + Z) * 2;
        Diff -> (X * 2 + 1 + Z) * 2
    end.