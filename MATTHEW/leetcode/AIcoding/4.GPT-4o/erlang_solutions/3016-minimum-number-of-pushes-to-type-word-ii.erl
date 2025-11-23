-module(solution).
-export([min_pushes/2]).

min_pushes(Word, Hand) ->
    HandList = string:to_list(Hand),
    WordList = string:to_list(Word),
    UniqueHand = lists:usort(HandList),
    count_pushes(WordList, UniqueHand, 0).

count_pushes([], _, Pushes) -> 
    Pushes;
count_pushes([H|T], Hand, Pushes) ->
    case lists:member(H, Hand) of
        true -> count_pushes(T, Hand, Pushes);
        false -> count_pushes(T, Hand, Pushes + 1)
    end.