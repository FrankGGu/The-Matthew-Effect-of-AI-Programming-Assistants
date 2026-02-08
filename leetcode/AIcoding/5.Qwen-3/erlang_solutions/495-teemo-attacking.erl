-module(teemo_attacking).
-export([teemo_attack/2]).

teemo_attack(Attack, Duration) ->
    teemo_attack(Attack, Duration, 0, 0).

teemo_attack([], _, _, Acc) ->
    Acc;
teemo_attack([Time | Rest], Duration, Last, Acc) ->
    if
        Time > Last ->
            NewAcc = Acc + min(Duration, Time - Last),
            teemo_attack(Rest, Duration, Time, NewAcc);
        true ->
            teemo_attack(Rest, Duration, Last, Acc)
    end.