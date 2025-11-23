-module(word_ladder).
-export([ladder_length/3]).

ladder_length(BeginWord, EndWord, WordList) ->
    Words = sets:from_list(WordList),
    if not sets:is_element(EndWord, Words) then
        0
    else
        queue_bfs(queue:new(), [{BeginWord, 1}], EndWord, Words)
    end.

queue_bfs(Queue, [{Word, Level} | Rest], EndWord, Words) ->
    if Word =:= EndWord then
        Level
    else
        Neighbors = get_neighbors(Word, Words),
        NewQueue = lists:foldl(fun(Neighbor, AccQueue) ->
                                        queue:in({Neighbor, Level + 1}, AccQueue)
                                end, Queue, Neighbors),

        NewWords = sets:del_element(Word, Words),

        case Rest of
            [] ->
                case queue:is_empty(NewQueue) of
                    true -> 0;
                    false ->
                        {Value, NewQueue2} = queue:out(NewQueue),
                        queue_bfs(NewQueue2, [Value], EndWord, NewWords)
                end;
            _ ->
                queue_bfs(NewQueue, Rest, EndWord, NewWords)
        end
    end;
queue_bfs(Queue, [], EndWord, Words) ->
    case queue:is_empty(Queue) of
        true -> 0;
        false ->
            {Value, NewQueue} = queue:out(Queue),
            queue_bfs(NewQueue, [Value], EndWord, Words)
    end.

get_neighbors(Word, Words) ->
    WordList = sets:to_list(Words),
    lists:filter(fun(W) -> is_one_edit_distance(Word, W) end, WordList).

is_one_edit_distance(Word1, Word2) ->
    if length(Word1) /= length(Word2) then
        false
    else
        diff_count(Word1, Word2, 0) =< 1
    end.

diff_count(Word1, Word2, Count) ->
    diff_count_helper(Word1, Word2, 1, Count).

diff_count_helper(Word1, Word2, Index, Count) ->
    if Index > length(Word1) then
        Count
    else
        if lists:nth(Index, string:to_list(Word1)) /= lists:nth(Index, string:to_list(Word2)) then
            diff_count_helper(Word1, Word2, Index + 1, Count + 1)
        else
            diff_count_helper(Word1, Word2, Index + 1, Count)
        end
    end.