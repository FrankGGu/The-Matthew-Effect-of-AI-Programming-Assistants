-module(solution).
-export([remove_duplicates/1]).

remove_duplicates(S) ->
    lists:reverse(fold_and_reduce(S, [])).

fold_and_reduce([], Acc) ->
    Acc;
fold_and_reduce([H | T], []) ->
    fold_and_reduce(T, [H]);
fold_and_reduce([H | T], [PrevH | PrevT] = Acc) ->
    if H == PrevH ->
        fold_and_reduce(T, PrevT);
    else
        fold_and_reduce(T, [H | Acc])
    end.