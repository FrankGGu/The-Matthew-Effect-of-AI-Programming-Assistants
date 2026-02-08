-module(solution).
-export([bulbSwitch/2]).

bulbSwitch(N, presses) when N < 1 -> 0;
bulbSwitch(N, 0) -> 1;
bulbSwitch(N, presses) -> 
    case presses rem 2 of
        0 -> 
            (N + 1) div 2;
        1 -> 
            N div 2 + N rem 2
    end.