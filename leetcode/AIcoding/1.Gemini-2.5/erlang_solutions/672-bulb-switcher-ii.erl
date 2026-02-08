-module(solution).
-export([bulbSwitcherII/2]).

bulbSwitcherII(N, M) ->
    case {N, M} of
        {_, 0} -> 1;
        {1, _} -> 2;
        {2, 1} -> 4;
        {2, _} -> 4;
        {_, 1} -> 5;
        {_, 2} -> 7;
        {_, _} -> 8
    end.