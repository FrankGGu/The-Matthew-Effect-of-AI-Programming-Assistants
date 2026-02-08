-module(solution).
-export([ladderLength/3]).

ladderLength(BeginWord, EndWord, WordList) ->
    WordSet = gb_sets:from_list(WordList),
    Queue = queue:in({BeginWord, 1}, queue:new()),
    Visited = gb_sets:from_list([BeginWord]),
    bfs(Queue, Visited, WordSet, EndWord).

bfs(Queue, _Visited, _WordSet, _EndWord) when queue:is_empty(Queue) ->
    0;
bfs(Queue, Visited, WordSet, EndWord) ->
    {{value, {CurrentWord, CurrentDistance}}, NewQueue1} = queue:out(Queue),

    if CurrentWord == EndWord ->
        CurrentDistance;
    true ->
        AllOneDiffWords = generate_all_one_diff_words(CurrentWord),

        {UpdatedQueue, UpdatedVisited} = lists:foldl(
            fun(NextWord, {AccQueue, AccVisited}) ->
                IsTarget = (NextWord == EndWord),
                IsInWordSet = gb_sets:is_element(NextWord, WordSet),

                if (IsTarget or IsInWordSet) and (not gb_sets:is_element(NextWord, AccVisited)) ->
                    {queue:in({NextWord, CurrentDistance + 1}, AccQueue), gb_sets:add(NextWord, AccVisited)};
                true ->
                    {AccQueue, AccVisited}
                end
            end,
            {NewQueue1, Visited},
            AllOneDiffWords
        ),
        bfs(UpdatedQueue, UpdatedVisited, WordSet, EndWord)
    end.

generate_all_one_diff_words(Word) ->
    WordLen = length(Word),
    Alphabet = "abcdefghijklmnopqrstuvwxyz",
    lists:flatmap(
        fun(Index) ->
            lists:filtermap(
                fun(Char) ->
                    NewWord = replace_char_at_index(Word, Index, Char),
                    if NewWord == Word ->
                        false;
                    true ->
                        {true, NewWord}
                    end
                end,
                Alphabet
            )
        end,
        lists:seq(0, WordLen - 1)
    ).

replace_char_at_index(List, Index, NewChar) ->
    lists:sublist(List, Index) ++ [NewChar] ++ lists:nthtail(Index + 1, List).