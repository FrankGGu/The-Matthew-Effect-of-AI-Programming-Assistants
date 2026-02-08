-module(solution).
-export([find_secret_word/2]).

find_secret_word(guesser, wordlist) ->
    loop(guesser, wordlist).

loop(guesser, wordlist) ->
    case wordlist of
        [] -> ok;
        _ ->
            guess = guesser:guess(wordlist),
            matches = count_matches(guess, wordlist),
            loop(guesser, filter_words(guess, matches, wordlist))
    end.

count_matches(guess, wordlist) ->
    lists:map(fun(W) -> count_matching_letters(guess, W) end, wordlist).

count_matching_letters(Word1, Word2) ->
    lists:zip(Word1, Word2)
    |> lists:filter(fun({C1, C2}) -> C1 =:= C2 end)
    |> length().

filter_words(guess, matches, wordlist) ->
    lists:filter(fun(W) -> count_matching_letters(guess, W) =:= hd(matches) end, wordlist).