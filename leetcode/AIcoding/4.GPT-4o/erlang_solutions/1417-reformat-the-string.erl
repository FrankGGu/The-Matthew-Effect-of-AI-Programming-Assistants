-module(solution).
-export([reformat/1]).

reformat(S) ->
    Letters = lists:filter(fun(C) -> C >= $a andalso C =< $z orelse C >= $A andalso C =< $Z end, list_to_list(S)),
    Digits = lists:filter(fun(C) -> C >= $0 andalso C =< $9 end, list_to_list(S)),
    LCount = length(Letters),
    DCount = length(Digits),
    case abs(LCount - DCount) > 1 of
        true -> "";
        false -> reformat_helper(Letters, Digits, LCount, DCount)
    end.

reformat_helper(Letters, Digits, LCount, DCount) ->
    case LCount >= DCount of
        true -> interleave(Letters, Digits, LCount, DCount);
        false -> interleave(Digits, Letters, DCount, LCount)
    end.

interleave([], []) -> "";
interleave([H|T], []) -> [H | interleave(T, [])];
interleave([], [H|T]) -> [H | interleave([], T)];
interleave([H1|T1], [H2|T2]) -> [H1, H2 | interleave(T1, T2)].