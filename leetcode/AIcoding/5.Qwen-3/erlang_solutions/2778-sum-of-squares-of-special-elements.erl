-module(special_squares).
-export([sum_of_squares/1]).

sum_of_squares(List) ->
    sum_of_squares(List, 1, 0).

sum_of_squares([], _, Acc) ->
    Acc;
sum_of_squares([H | T], Index, Acc) ->
    case is_special(Index) of
        true ->
            sum_of_squares(T, Index + 1, Acc + H * H);
        false ->
            sum_of_squares(T, Index + 1, Acc)
    end.

is_special(N) ->
    N rem 3 == 1.