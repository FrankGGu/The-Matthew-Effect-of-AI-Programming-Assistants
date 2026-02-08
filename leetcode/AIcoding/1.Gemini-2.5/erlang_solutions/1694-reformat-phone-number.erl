-module(solution).
-export([reformatPhoneNumber/1]).

reformatPhoneNumber(S) ->
    Digits = [C || C <- S, C >= $0, C =< $9],
    reformat_helper(Digits, length(Digits)).

reformat_helper(Digits, Len) ->
    case Len of
        0 -> [];
        1 -> Digits;
        2 -> Digits;
        3 -> Digits;
        4 -> lists:sublist(Digits, 1, 2) ++ [$ - $] ++ lists:sublist(Digits, 3, 2);
        _ -> % Len > 4
            Head = lists:sublist(Digits, 1, 3),
            Tail = lists:nthtail(3, Digits),
            Head ++ [$ - $] ++ reformat_helper(Tail, Len - 3)
    end.