-module(solution).
-export([makeGood/1]).

makeGood(S) ->
    lists:reverse(make_good_acc(S, [])).

make_good_acc([], Acc) ->
    Acc;
make_good_acc([H|T], []) ->
    make_good_acc(T, [H]);
make_good_acc([H|T], [Prev|RestAcc]) when abs(H - Prev) == 32 ->
    make_good_acc(T, RestAcc);
make_good_acc([H|T], Acc) ->
    make_good_acc(T, [H|Acc]).