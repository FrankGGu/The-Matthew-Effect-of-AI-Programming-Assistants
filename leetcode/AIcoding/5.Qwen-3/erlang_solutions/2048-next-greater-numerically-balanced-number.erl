-module(nex_greater_numerically_balanced_number).
-export([next_num/1]).

next_num(N) ->
    Next = N + 1,
    find_next(Next).

find_next(N) ->
    case is_balanced(N) of
        true -> N;
        false -> find_next(N + 1)
    end.

is_balanced(N) ->
    Digits = integer_to_list(N),
    Length = length(Digits),
    Set = sets:from_list(Digits),
    lists:all(fun(D) -> D >= $1 andalso D =< (Length + $0) end, Digits),
    lists:sort(Digits) == lists:seq($1, $0 + Length).

is_balanced_permutation(Digits, Length) ->
    Sorted = lists:sort(Digits),
    lists:all(fun(I) -> lists:member(integer_to_list(I), Digits) end, lists:seq(1, Length)).

integer_to_list(N) ->
    erlang:integer_to_list(N).