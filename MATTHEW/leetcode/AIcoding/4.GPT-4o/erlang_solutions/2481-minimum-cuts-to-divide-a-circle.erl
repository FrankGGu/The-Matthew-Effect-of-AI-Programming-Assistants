-module(solution).
-export([min_cuts/1]).

min_cuts(N) when N == 0; N == 1 -> 0;
min_cuts(N) -> 
    case N rem 2 of
        0 -> N div 2;
        _ -> N
    end.