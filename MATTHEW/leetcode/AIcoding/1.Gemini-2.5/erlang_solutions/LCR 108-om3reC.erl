-module(solution).
-export([ladderLength/3]).

ladderLength(BeginWord, EndWord, WordList) ->
    WordSet = gb_sets:from_list(WordList),

    case gb_sets:is_member(EndWord, WordSet) of
        false -> 0;
        true ->
            BFSQueue = queue:in({BeginWord, 1}, queue:new()),
            Visited = gb_sets:add(BeginWord, gb_sets:new()),

            bfs(BFSQueue, EndWord, WordSet, Visited)
    end.

bfs(Queue, EndWord, WordSet, Visited) ->
    case queue:out(Queue) of
        {{value, {CurrentWord, Distance}}, RestQueue} ->
            if CurrentWord == EndWord ->
                Distance;
            true ->
                Neighbors = get_neighbors(CurrentWord, WordSet, Visited),

                NewVisited = lists:foldl(fun(W, Acc) -> gb_sets:add(W, Acc) end, Visited, Neighbors),

                NewQueue = lists:foldl(
                    fun(Neighbor, AccQ) ->
                        queue:in({Neighbor, Distance + 1}, AccQ)
                    end,
                    RestQueue,
                    Neighbors
                ),

                bfs(NewQueue, EndWord, WordSet, NewVisited)
            end;
        {empty, _} ->
            0
    end.

get_neighbors(Word, WordSet, Visited) ->
    WordLen = length(Word),
    lists:foldl(
        fun(Idx, AccNeighbors) ->
            lists:foldl(
                fun(Char, AccCharNeighbors) ->
                    NewWord = replace_char(Word, Idx, Char),
                    case gb_sets:is_member(NewWord, WordSet) andalso not gb_sets:is_member(NewWord, Visited) of
                        true -> [NewWord | AccCharNeighbors];
                        false -> AccCharNeighbors
                    end
                end,
                AccNeighbors,
                lists:seq($a, $z)
            )
        end,
        [],
        lists:seq(0, WordLen - 1)
    ).

replace_char(Word, Index, NewChar) ->
    lists:sublist(Word, 1, Index) ++ [NewChar] ++ lists:nthtail(Index + 1, Word).