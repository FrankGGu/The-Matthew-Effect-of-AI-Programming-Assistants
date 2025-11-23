-module(solution).
-export([find_min/1]).

find_min([]) -> 0;
find_min([H|T]) -> find_min(T, H).

find_min([], Min) -> Min;
find_min([H|T], Min) when H < Min -> find_min(T, H);
find_min([_|T], Min) -> find_min(T, Min).