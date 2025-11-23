-module(solution).
-export([findSecretWord/2]).

findSecretWord(Wordlist, _Master) ->
    Guess = hd(Wordlist),
    Matches = guess(Guess, _Master),
    case Matches of
        6 -> ok;
        _ -> 
            NewWordlist = [Word || Word <- Wordlist, matches(Guess, Word) == Matches],
            findSecretWord(NewWordlist, _Master)
    end.

matches(Guess, Word) ->
    lists:sum([1 || {G, W} <- lists:zip(Guess, Word), G == W]).

guess(Guess, Master) ->
    Master:guess(Guess).