-module(unique_morse_code_words).
-export([unique_morse/1]).

unique_morse(Words) ->
    Morse = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.",
             "-.--","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."],
    MorseMap = lists:zip(lists:seq(97, 122), Morse),
    WordsSet = sets:from_list(Words),
    MorseCodes = lists:map(fun(W) -> 
        lists:foldl(fun(Char, Acc) ->
            [M | _] = lists:keyfind(Char, 1, MorseMap),
            Acc ++ M
        end, "", W)
    end, sets:to_list(WordsSet)),
    sets:size(sets:from_list(MorseCodes)).