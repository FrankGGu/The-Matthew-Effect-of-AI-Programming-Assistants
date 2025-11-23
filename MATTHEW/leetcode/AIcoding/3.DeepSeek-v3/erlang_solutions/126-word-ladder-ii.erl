-module(solution).
-export([find_ladders/3]).

find_ladders(BeginWord, EndWord, WordList) ->
    case lists:member(EndWord, WordList) of
        false -> [];
        true ->
            Dict = sets:from_list(WordList),
            Queue = queue:in([BeginWord], queue:new()),
            Visited = sets:from_list([BeginWord]),
            Result = bfs(Queue, EndWord, Dict, Visited, #{}),
            case maps:get(EndWord, Result, none) of
                none -> [];
                Paths -> lists:map(fun lists:reverse/1, Paths)
            end
    end.

bfs(Queue, EndWord, Dict, Visited, Paths) ->
    case queue:is_empty(Queue) of
        true -> Paths;
        false ->
            {{value, Path}, Q2} = queue:out(Queue),
            LastWord = lists:last(Path),
            case LastWord =:= EndWord of
                true ->
                    NewPaths = case maps:get(EndWord, Paths, none) of
                        none -> [Path];
                        Existing -> [Path | Existing]
                    end,
                    bfs(Q2, EndWord, Dict, Visited, Paths#{EndWord => NewPaths});
                false ->
                    Neighbors = get_neighbors(LastWord, Dict),
                    {NewQueue, NewVisited, NewPaths} = 
                        lists:foldl(fun(Word, {QAcc, VAcc, PAcc}) ->
                            case sets:is_element(Word, VAcc) of
                                false ->
                                    NewPath = Path ++ [Word],
                                    NewQ = queue:in(NewPath, QAcc),
                                    NewV = sets:add_element(Word, VAcc),
                                    NewP = case maps:get(Word, PAcc, none) of
                                        none -> PAcc#{Word => [NewPath]};
                                        ExistingPaths -> PAcc#{Word => [NewPath | ExistingPaths]}
                                    end,
                                    {NewQ, NewV, NewP};
                                true ->
                                    {QAcc, VAcc, PAcc}
                            end
                        end, {Q2, Visited, Paths}, Neighbors),
                    bfs(NewQueue, EndWord, Dict, NewVisited, NewPaths)
            end
    end.

get_neighbors(Word, Dict) ->
    Chars = "abcdefghijklmnopqrstuvwxyz",
    WordList = binary_to_list(Word),
    lists:foldl(fun(I, Acc) ->
        OriginalChar = lists:nth(I, WordList),
        lists:foldl(fun(C, Acc2) ->
            case C =:= OriginalChar of
                true -> Acc2;
                false ->
                    NewWordList = lists:sublist(WordList, I - 1) ++ [C] ++ lists:nthtail(I, WordList),
                    NewWord = list_to_binary(NewWordList),
                    case sets:is_element(NewWord, Dict) of
                        true -> [NewWord | Acc2];
                        false -> Acc2
                    end
            end
        end, Acc, Chars)
    end, [], lists:seq(1, length(WordList))).