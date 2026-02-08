-module(solution).
-export([minimum_jumps/3]).

minimum_jumps(Forbidden, A, B) ->
    MaxLimit = 2000 + 2 * B,
    ForbiddenSet = sets:from_list(Forbidden),
    Visited = sets:new(),
    Queue = [{0, 0, false}],
    bfs(Queue, ForbiddenSet, Visited, A, B, MaxLimit).

bfs([], _, _, _, _, _) -> -1;
bfs([{Pos, Steps, IsBack} | Rest], ForbiddenSet, Visited, A, B, MaxLimit) ->
    case Pos =:= 0 andalso Steps > 0 of
        true -> Steps;
        false ->
            NewVisited = sets:add_element({Pos, IsBack}, Visited),
            NextPos1 = Pos + A,
            NextPos2 = Pos - B,
            NewQueue1 = case NextPos1 =< MaxLimit andalso not sets:is_element(NextPos1, ForbiddenSet) andalso not sets:is_element({NextPos1, false}, NewVisited) of
                true -> [{NextPos1, Steps + 1, false} | Rest];
                false -> Rest
            end,
            NewQueue2 = case not IsBack andalso NextPos2 >= 0 andalso not sets:is_element(NextPos2, ForbiddenSet) andalso not sets:is_element({NextPos2, true}, NewVisited) of
                true -> [{NextPos2, Steps + 1, true} | NewQueue1];
                false -> NewQueue1
            end,
            bfs(NewQueue2, ForbiddenSet, NewVisited, A, B, MaxLimit)
    end.