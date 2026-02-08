-module(solution).
-export([pushes/2]).

pushes(Word, Hand) ->
    HandList = string:to_list(Hand),
    WordList = string:to_list(Word),
    pushes_helper(WordList, HandList, 0).

pushes_helper([], _, Pushes) -> Pushes;
pushes_helper([H | T], Hand, Pushes) ->
    case lists:member(H, Hand) of
        true -> pushes_helper(T, Hand, Pushes);
        false -> pushes_helper(T, Hand, Pushes + 1)
    end.