-module(word_ladder_ii).
-export([findLadders/2]).

findLadders(BeginWord, EndWord, WordList) ->
    WordSet = sets:from_list(WordList),
    if not sets:is_element(EndWord, WordSet) then
        []
    else
        Q = queue:new(),
        Q1 = queue:in({BeginWord, [BeginWord]}, Q),
        Visited = sets:new(),
        Visited1 = sets:add_element(BeginWord, Visited),
        Result = findLaddersHelper(Q1, EndWord, WordSet, Visited1, []),
        MinLen =
            case Result of
                [] ->
                    infinity;
                _ ->
                    lists:min([length(Path) || Path <- Result])
            end,
        [Path || Path <- Result, length(Path) == MinLen]
    end.

findLaddersHelper(Q, EndWord, WordSet, Visited, Acc) ->
    if queue:is_empty(Q) then
        Acc
    else
        {Value, Q1} = queue:out(Q),
        {Word, Path} = Value,
        if Word == EndWord then
            findLaddersHelper(Q1, EndWord, WordSet, Visited, [Path | Acc])
        else
            Neighbors = getNeighbors(Word, WordSet),
            NewNeighbors = [N || N <- Neighbors, not sets:is_element(N, Visited)],
            if NewNeighbors == [] then
                findLaddersHelper(Q1, EndWord, WordSet, Visited, Acc)
            else
                Visited2 = lists:foldl(fun(X, Y) -> sets:add_element(X, Y) end, Visited, NewNeighbors),
                Q2 = lists:foldl(fun(X, Y) -> queue:in({X, Path ++ [X]}, Y) end, Q1, NewNeighbors),
                findLaddersHelper(Q2, EndWord, WordSet, Visited2, Acc)
            end
        end
    end.

getNeighbors(Word, WordSet) ->
    Len = length(Word),
    getNeighborsHelper(Word, WordSet, 0, Len, []).

getNeighborsHelper(Word, WordSet, Index, Len, Acc) ->
    if Index >= Len then
        Acc
    else
        Char = element(Index + 1, string:to_list(Word)),
        Neighbors =
            lists:foldl(
                fun(C, Acc2) ->
                    if C == Char then
                        Acc2
                    else
                        NewWord = replaceChar(Word, Index, C),
                        if sets:is_element(NewWord, WordSet) then
                            [NewWord | Acc2]
                        else
                            Acc2
                        end
                    end
                end,
                [],
                lists:seq($a, $z)
            ),
        getNeighborsHelper(Word, WordSet, Index + 1, Len, Acc ++ Neighbors)
    end.

replaceChar(Word, Index, Char) ->
    List = string:to_list(Word),
    lists:nth(Index + 1, List, Char),
    list_to_binary(List).

infinity() ->
    1 bsl 60.