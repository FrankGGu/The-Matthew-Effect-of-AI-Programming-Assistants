-module(solution).
-export([solve/1]).

solve(S) ->
    Letters = [C || C <- S, is_letter(C)],
    ReversedLetters = lists:reverse(Letters),
    reverse_and_reconstruct(S, ReversedLetters).

is_letter(C) when C >= $a andalso C <= $z -> true;
is_letter(C) when C >= $A andalso C <= $Z -> true;
is_letter(_) -> false.

reverse_and_reconstruct([], _) -> [];
reverse_and_reconstruct([H|T], ReversedLetters) when is_letter(H) ->
    [LetterHead|LetterTail] = ReversedLetters,
    [LetterHead | reverse_and_reconstruct(T, LetterTail)];
reverse_and_reconstruct([H|T], ReversedLetters) ->
    [H | reverse_and_reconstruct(T, ReversedLetters)].