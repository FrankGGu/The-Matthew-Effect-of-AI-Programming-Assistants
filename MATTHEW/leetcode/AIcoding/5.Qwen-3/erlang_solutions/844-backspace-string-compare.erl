-module(backspace_string_compare).
-export([backspace/2]).

backspace(S1, S2) ->
    compare(lists:reverse(process(S1)), lists:reverse(process(S2))).

process(S) ->
    process(S, []).

process([], Acc) ->
    Acc;
process([C | Rest], Acc) ->
    if
        C == #$ -> 
            process(Rest, tl(Acc));
        true ->
            process(Rest, [C | Acc])
    end.

compare([], []) ->
    true;
compare([], _) ->
    false;
compare(_, []) ->
    false;
compare([C1 | Rest1], [C2 | Rest2]) ->
    if
        C1 == C2 ->
            compare(Rest1, Rest2);
        true ->
            false
    end.