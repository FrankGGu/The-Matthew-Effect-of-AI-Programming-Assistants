-module(solution).
-export([is_prefix/2]).

is_prefix(S, Words) ->
    S_len = length(S),
    check_prefix_acc(S, S_len, Words, [], 0).

check_prefix_acc(S, S_len, [Word | RestWords], CurrentAcc, CurrentAcc_len) ->
    Word_len = length(Word),
    NewAcc_len = CurrentAcc_len + Word_len,
    case NewAcc_len of
        S_len ->
            NewAcc = CurrentAcc ++ Word,
            NewAcc == S;
        _ when NewAcc_len > S_len ->
            false;
        _ ->
            NewAcc = CurrentAcc ++ Word,
            check_prefix_acc(S, S_len, RestWords, NewAcc, NewAcc_len)
    end;
check_prefix_acc(_S, _S_len, [], _CurrentAcc, _CurrentAcc_len) ->
    false.