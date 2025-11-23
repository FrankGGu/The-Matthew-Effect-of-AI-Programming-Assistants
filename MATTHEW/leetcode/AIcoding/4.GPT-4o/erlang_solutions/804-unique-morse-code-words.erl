-module(solution).
-export([unique_morse_representations/1]).

unique_morse_representations(Words) ->
    MorseCodes = [".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."],
    UniqueMorse = lists:usort(lists:map(fun(W) -> 
        lists:map(fun(C) -> lists:nth((C - $a + 1), MorseCodes) end, list_to_tuple(W)) 
    end, Words)),
    length(UniqueMorse).