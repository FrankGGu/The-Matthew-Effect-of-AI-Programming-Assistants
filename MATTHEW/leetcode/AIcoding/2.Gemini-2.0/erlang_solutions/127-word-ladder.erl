-module(word_ladder).
-export([ladder_length/3]).

ladder_length(BeginWord, EndWord, WordList) ->
    Words = sets:from_list(WordList),
    case sets:is_element(EndWord, Words) of
        false ->
            0;
        true ->
            bfs(BeginWord, EndWord, Words)
    end.

bfs(BeginWord, EndWord, Words) ->
    Queue = queue:new(),
    Queue1 = queue:in({BeginWord, 1}, Queue),
    Visited = sets:new(),
    Visited1 = sets:add_element(BeginWord, Visited),
    bfs_helper(EndWord, Words, Queue1, Visited1).

bfs_helper(EndWord, Words, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true ->
            0;
        false ->
            {{Value, Queue2}, Queue3} = queue:out(Queue),
            {Word, Level} = Value,
            case Word =:= EndWord of
                true ->
                    Level;
                false ->
                    Neighbors = get_neighbors(Word, Words, Visited),
                    Queue4 = lists:foldl(fun(Neighbor, Acc) -> queue:in({Neighbor, Level + 1}, Acc) end, Queue3, Neighbors),
                    Visited2 = lists:foldl(fun(Neighbor, Acc) -> sets:add_element(Neighbor, Acc) end, Visited, Neighbors),
                    bfs_helper(EndWord, Words, Queue4, Visited2)
            end
    end.

get_neighbors(Word, Words, Visited) ->
    WordList = sets:to_list(Words),
    lists:filter(fun(W) -> is_neighbor(Word, W) and not sets:is_element(W, Visited) end, WordList).

is_neighbor(Word1, Word2) ->
    case string:len(Word1) =:= string:len(Word2) of
        false ->
            false;
        true ->
            Length = string:len(Word1),
            is_neighbor_helper(Word1, Word2, Length, 0)
    end.

is_neighbor_helper(_Word1, _Word2, 0, Diff) ->
    Diff =:= 1;
is_neighbor_helper(Word1, Word2, Length, Diff) ->
    case string:substr(Word1, Length, 1) =:= string:substr(Word2, Length, 1) of
        true ->
            is_neighbor_helper(Word1, Word2, Length - 1, Diff);
        false ->
            is_neighbor_helper(Word1, Word2, Length - 1, Diff + 1)
    end.