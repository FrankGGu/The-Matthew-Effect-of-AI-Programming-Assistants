-module(unique_morse_code_words).
-export([uniqueMorseRepresentations/1]).

uniqueMorseRepresentations(Words) ->
  MorseCodes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."],
  MorseWords = lists:map(fun(Word) -> toMorse(Word, MorseCodes) end, Words),
  length(lists:usort(MorseWords)).

toMorse(Word, MorseCodes) ->
  toMorse(Word, MorseCodes, []).

toMorse([], _, Acc) ->
  lists:reverse(Acc);
toMorse([H|T], MorseCodes, Acc) ->
  Index = H - $a + 1,
  MorseCode = lists:nth(Index, MorseCodes),
  toMorse(T, MorseCodes, [MorseCode|Acc]).