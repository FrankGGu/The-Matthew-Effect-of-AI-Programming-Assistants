-module(running_sum).
-export([running_sum/1]).

running_sum([]) -> [];
running_sum([H|T]) ->
    running_sum(T, H, [H]).

running_sum([], _, Acc) -> lists:reverse(Acc);
running_sum([H|T], Prev, Acc) ->
    New = H + Prev,
    running_sum(T, New, [New | Acc]).