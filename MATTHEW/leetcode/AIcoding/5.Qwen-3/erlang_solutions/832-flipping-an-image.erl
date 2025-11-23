-module(solution).
-export([flip_and_invert/1]).

flip_and_invert(Image) ->
    lists:map(fun(Row) -> invert_row(lists:reverse(Row)) end, Image).

invert_row([]) ->
    [];
invert_row([H | T]) ->
    [1 - H | invert_row(T)].