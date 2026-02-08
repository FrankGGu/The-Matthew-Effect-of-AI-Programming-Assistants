-module(solution).
-export([percentage_letters/1]).

percentage_letters(S) ->
    Length = string:length(S),
    Count = count_letter(S, $a),
    (Count * 100) / Length.

count_letter([], _) -> 0;
count_letter([H | T], C) ->
    if H == C -> 1 + count_letter(T, C);
       true -> count_letter(T, C)
    end.