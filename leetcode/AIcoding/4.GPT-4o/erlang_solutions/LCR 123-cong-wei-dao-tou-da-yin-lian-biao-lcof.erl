-module(solution).
-export([min_books/1]).

min_books(N) when N < 0 -> 0;
min_books(0) -> 0;
min_books(N) ->
    min_books(N - 1) + min_books(N - 2) + 1.