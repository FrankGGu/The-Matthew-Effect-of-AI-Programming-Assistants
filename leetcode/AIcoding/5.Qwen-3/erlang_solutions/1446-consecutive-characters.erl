-module(solution).
-export([maxPower/1]).

maxPower(<<C, Rest/binary>>) ->
    maxPower(Rest, C, 1, 1);
maxPower(_) ->
    0.

maxPower(<<C, Rest/binary>>, CurrentChar, CurrentCount, MaxCount) ->
    if
        C == CurrentChar ->
            maxPower(Rest, CurrentChar, CurrentCount + 1, max(CurrentCount + 1, MaxCount));
        true ->
            maxPower(Rest, C, 1, MaxCount)
    end;
maxPower(_, _, _, MaxCount) ->
    MaxCount.