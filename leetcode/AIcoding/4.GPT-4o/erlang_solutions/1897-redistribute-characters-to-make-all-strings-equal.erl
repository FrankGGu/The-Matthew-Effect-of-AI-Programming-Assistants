-module(solution).
-export([makeEqual/1]).

makeEqual(Chars) ->
    Total = lists:sum(lists:map(fun(X) -> list_to_integer(X) end, Chars)),
    Length = length(Chars),
    Total rem Length == 0.