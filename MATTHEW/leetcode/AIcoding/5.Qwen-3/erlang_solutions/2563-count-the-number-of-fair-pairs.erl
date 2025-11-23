-module(solution).
-export([num_fair_pairs/1]).

num_fair_pairs(A) ->
    num_fair_pairs(A, 0, length(A) - 1).

num_fair_pairs(_, _, L) when L < 0 -> 0;
num_fair_pairs(A, Start, End) ->
    Mid = (Start + End) div 2,
    Left = num_fair_pairs(A, Start, Mid - 1),
    Right = num_fair_pairs(A, Mid + 1, End),
    Count = count_pairs(A, Start, Mid, End),
    Left + Right + Count.

count_pairs(A, Start, Mid, End) ->
    count_pairs(A, Start, Mid, End, 0).

count_pairs(_A, _Start, _Mid, End, Acc) when End < 0 -> Acc;
count_pairs(A, Start, Mid, End, Acc) ->
    Val = lists:nth(End + 1, A),
    Count = count_less(A, Start, Mid, Val),
    count_pairs(A, Start, Mid, End - 1, Acc + Count).

count_less(_A, _Start, _Mid, _Val) when _Start > _Mid -> 0;
count_less(A, Start, Mid, Val) ->
    MidVal = lists:nth(Mid + 1, A),
    if
        MidVal < Val ->
            count_less(A, Start, Mid - 1, Val);
        true ->
            count_less(A, Start, Mid - 1, Val) + (Mid - Start + 1)
    end.