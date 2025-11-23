-module(word_ladder).
-export([ladder_length/2]).

ladder_length(StartWord, EndWord) ->
    ladder_length(StartWord, EndWord, 1, dict:new(), [StartWord]).

ladder_length(_, EndWord, _, _, _) when EndWord == [] -> 0;
ladder_length(StartWord, EndWord, Length, Visited, Queue) ->
    case Queue of
        [] -> 0;
        [Current | Rest] ->
            if
                Current == EndWord -> Length;
                true ->
                    NewVisited = dict:store(Current, true, Visited),
                    NextWords = generate_next_words(Current),
                    NewQueue = lists:foldl(fun(W, Q) ->
                        if
                            dict:is_key(W, NewVisited) -> Q;
                            true -> [W | Q]
                        end
                    end, Rest, NextWords),
                    ladder_length(StartWord, EndWord, Length + 1, NewVisited, NewQueue)
            end
    end.

generate_next_words(Word) ->
    Words = ["hot","dot","dog","lot","log","hit","cog"],
    lists:filter(fun(W) -> is_one_letter_diff(Word, W) end, Words).

is_one_letter_diff(A, B) ->
    lists:sum([1 || {X, Y} <- lists:zip(A, B), X /= Y]) == 1.