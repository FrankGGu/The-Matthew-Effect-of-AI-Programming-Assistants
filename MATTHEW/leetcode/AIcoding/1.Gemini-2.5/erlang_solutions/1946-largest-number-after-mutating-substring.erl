-module(solution).
-export([largest_number/2]).

largest_number(NumStr, Change) ->
    Digits = [C - $0 || C <- NumStr],
    ResultDigits = mutate(Digits, Change, [], before_mutation),
    [D + $0 || D <- ResultDigits].

mutate([], _Change, Acc, _State) ->
    lists:reverse(Acc);
mutate([H|T], Change, Acc, before_mutation) ->
    H_val = H,
    Changed_H_val = lists:nth(H_val + 1, Change),
    if
        Changed_H_val > H_val ->
            mutate(T, Change, [Changed_H_val | Acc], in_mutation);
        true ->
            mutate(T, Change, [H_val | Acc], before_mutation)
    end;
mutate([H|T], Change, Acc, in_mutation) ->
    H_val = H,
    Changed_H_val = lists:nth(H_val + 1, Change),
    if
        Changed_H_val >= H_val ->
            mutate(T, Change, [Changed_H_val | Acc], in_mutation);
        true ->
            mutate(T, Change, [H_val | Acc], after_mutation)
    end;
mutate([H|T], Change, Acc, after_mutation) ->
    mutate(T, Change, [H | Acc], after_mutation).