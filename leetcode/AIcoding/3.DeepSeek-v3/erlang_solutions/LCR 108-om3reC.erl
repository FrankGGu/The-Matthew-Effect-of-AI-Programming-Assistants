-module(solution).
-export([ladder_length/3]).

ladder_length(BeginWord, EndWord, WordList) ->
    WordSet = sets:from_list(WordList),
    case not sets:is_element(EndWord, WordSet) of
        true -> 0;
        false ->
            Queue = queue:in({BeginWord, 1}, queue:new()),
            Visited = sets:from_list([BeginWord]),
            bfs(Queue, WordSet, Visited, EndWord)
    end.

bfs(Queue, WordSet, Visited, EndWord) ->
    case queue:out(Queue) of
        {empty, _} -> 0;
        {{value, {CurrentWord, Level}}, NewQueue} ->
            case CurrentWord =:= EndWord of
                true -> Level;
                false ->
                    NextWords = generate_next_words(CurrentWord, WordSet, Visited),
                    NewVisited = lists:foldl(fun(Word, Acc) -> sets:add_element(Word, Acc) end, Visited, NextWords),
                    UpdatedQueue = lists:foldl(fun(Word, Acc) -> queue:in({Word, Level + 1}, Acc) end, NewQueue, NextWords),
                    bfs(UpdatedQueue, WordSet, NewVisited, EndWord)
            end
    end.

generate_next_words(Word, WordSet, Visited) ->
    Chars = "abcdefghijklmnopqrstuvwxyz",
    WordList = binary_to_list(Word),
    NextWords = lists:foldl(
        fun(I, Acc) ->
            Prefix = lists:sublist(WordList, I - 1),
            Suffix = lists:nthtail(I, WordList),
            lists:foldl(
                fun(C, InnerAcc) ->
                    NewWord = Prefix ++ [C] ++ Suffix,
                    case sets:is_element(NewWord, WordSet) andalso not sets:is_element(NewWord, Visited) of
                        true -> [NewWord | InnerAcc];
                        false -> InnerAcc
                    end
                end,
                Acc,
                Chars
            )
        end,
        [],
        lists:seq(1, length(WordList))
    ),
    NextWords.