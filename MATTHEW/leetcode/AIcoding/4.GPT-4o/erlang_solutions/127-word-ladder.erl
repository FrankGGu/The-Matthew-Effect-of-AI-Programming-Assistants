%% -spec ladder_length(BeginWord :: unicode:unicode_binary(), EndWord :: unicode:unicode_binary(), WordList :: [unicode:unicode_binary()]) -> integer().
ladder_length(BeginWord, EndWord, WordList) ->
    ladder_length([BeginWord], EndWord, WordList, 1).

ladder_length([], _, _, _) -> 0;
ladder_length([Current | Rest], EndWord, WordList, Steps) when Current =:= EndWord -> Steps;
ladder_length([Current | Rest], EndWord, WordList, Steps) ->
    NextWords = get_neighbors(Current, WordList),
    ladder_length(Rest ++ NextWords, EndWord, lists:subtract(WordList, NextWords), Steps + 1).

get_neighbors(Current, WordList) ->
    lists:filter(fun(Word) -> differs_by_one(Current, Word) end, WordList).

differs_by_one(W1, W2) ->
    list:zip(W1, W2)
    |> lists:filter(fun({C1, C2}) -> C1 /= C2 end)
    |> length() =:= 1.
