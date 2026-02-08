-module(solution).
-export([score_of_string/1]).

score_of_string(Str) ->
    score(Str, 0).

score([], Acc) ->
    Acc;
score([H | T], Acc) when H == $A ->
    score(T, Acc + 1);
score([H | T], Acc) when H == $B ->
    score(T, Acc + 2);
score([H | T], Acc) when H == $C ->
    score(T, Acc + 3);
score([H | T], Acc) when H == $D ->
    score(T, Acc + 4);
score([H | T], Acc) when H == $E ->
    score(T, Acc + 5);
score([H | T], Acc) when H == $F ->
    score(T, Acc + 6);
score([H | T], Acc) when H == $G ->
    score(T, Acc + 7);
score([H | T], Acc) when H == $H ->
    score(T, Acc + 8);
score([H | T], Acc) when H == $I ->
    score(T, Acc + 9);
score([H | T], Acc) when H == $J ->
    score(T, Acc + 10);
score([H | T], Acc) when H == $K ->
    score(T, Acc + 11);
score([H | T], Acc) when H == $L ->
    score(T, Acc + 12);
score([H | T], Acc) when H == $M ->
    score(T, Acc + 13);
score([H | T], Acc) when H == $N ->
    score(T, Acc + 14);
score([H | T], Acc) when H == $O ->
    score(T, Acc + 15);
score([H | T], Acc) when H == $P ->
    score(T, Acc + 16);
score([H | T], Acc) when H == $Q ->
    score(T, Acc + 17);
score([H | T], Acc) when H == $R ->
    score(T, Acc + 18);
score([H | T], Acc) when H == $S ->
    score(T, Acc + 19);
score([H | T], Acc) when H == $T ->
    score(T, Acc + 20);
score([H | T], Acc) when H == $U ->
    score(T, Acc + 21);
score([H | T], Acc) when H == $V ->
    score(T, Acc + 22);
score([H | T], Acc) when H == $W ->
    score(T, Acc + 23);
score([H | T], Acc) when H == $X ->
    score(T, Acc + 24);
score([H | T], Acc) when H == $Y ->
    score(T, Acc + 25);
score([H | T], Acc) when H == $Z ->
    score(T, Acc + 26);
score([_H | T], Acc) ->
    score(T, Acc).