-spec find_ladders(BeginWord :: unicode:unicode_binary(), EndWord :: unicode:unicode_binary(), WordList :: [unicode:unicode_binary()]) -> [[unicode:unicode_binary()]].
find_ladders(BeginWord, EndWord, WordList) ->
    find_ladders(BeginWord, EndWord, WordList, [], []).

find_ladders(_, _, [], Paths, Results) -> Results;
find_ladders(BeginWord, EndWord, [NextWord | Rest], Paths, Results) when valid_word(BeginWord, NextWord) ->
    find_ladders(NextWord, EndWord, Rest, [NextWord | Paths], Results);
find_ladders(BeginWord, EndWord, [NextWord | Rest], Paths, Results) ->
    find_ladders(BeginWord, EndWord, Rest, Paths, Results).

valid_word(Word1, Word2) ->
    length([1 || {X, Y} <- lists:zip(Word1, Word2), X /= Y]) == 1.
