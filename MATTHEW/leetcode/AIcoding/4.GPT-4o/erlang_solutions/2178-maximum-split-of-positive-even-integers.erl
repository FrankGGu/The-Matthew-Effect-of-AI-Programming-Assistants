-module(solution).
-export([maximum_even_split/1]).

maximum_even_split(N) when N rem 2 =:= 1 -> [];
maximum_even_split(N) -> 
    lists:seq(2, N div 2 * 2, 2).