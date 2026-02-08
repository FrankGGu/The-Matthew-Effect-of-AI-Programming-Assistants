-module(solution).
-export([split_message/2]).

split_message(Message, Limit) ->
    split_message(Message, Limit, 1, []).

split_message(_, _, _, Acc) when length(Acc) > 0 andalso length(lists:flatten(Acc)) >= Limit ->
    lists:reverse(Acc);
split_message([], _, _, Acc) ->
    lists:reverse(Acc);
split_message([H | T], Limit, Index, Acc) ->
    Current = [H],
    NextAcc = [Current | Acc],
    if
        length(lists:flatten(NextAcc)) < Limit ->
            split_message(T, Limit, Index + 1, NextAcc);
        true ->
            split_message(T, Limit, Index + 1, Acc)
    end.