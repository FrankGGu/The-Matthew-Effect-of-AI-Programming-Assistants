-module(solution).
-export([ladder_length/2]).

ladder_length(BeginWord, EndWord) ->
    WordList = ["hot","dot","dog","lot","log","cog"],
    case lists:member(EndWord, WordList) of
        false -> 0;
        true ->
            Queue = queue:in({BeginWord, 1}, queue:new()),
            Visited = sets:add_element(BeginWord, sets:new()),
            bfs(Queue, WordList, EndWord, Visited)
    end.

bfs(Queue, WordList, EndWord, Visited) ->
    case queue:out(Queue) of
        {empty, _} -> 0;
        {{value, {CurrentWord, Steps}}, Q} ->
            case CurrentWord =:= EndWord of
                true -> Steps;
                false ->
                    NewQueue = lists:foldl(fun(Word, Acc) ->
                        case sets:is_element(Word, Visited) of
                            false ->
                                case is_one_letter_diff(CurrentWord, Word) of
                                    true ->
                                        NewVisited = sets:add_element(Word, Visited),
                                        queue:in({Word, Steps + 1}, Acc);
                                    false -> Acc
                                end;
                            true -> Acc
                        end
                    end, Q, WordList),
                    bfs(NewQueue, WordList, EndWord, Visited)
            end
    end.

is_one_letter_diff(Word1, Word2) ->
    lists:sum(lists:zipwith(fun(C1, C2) -> if C1 =:= C2 -> 0; true -> 1 end end, Word1, Word2)) =:= 1.