-module(solution).
-export([number_of_cuts/1]).

number_of_cuts(1) -> 0;
number_of_cuts(N) when N rem 2 == 0 -> N div 2;
number_of_cuts(N) when N rem 2 == 1 -> N.