-module(solution).
-export([max_beautiful_bouquet/1]).

max_beautiful_bouquet(N) when N < 1 -> 0;
max_beautiful_bouquet(N) -> 
    1 + (N div 2) * 2.