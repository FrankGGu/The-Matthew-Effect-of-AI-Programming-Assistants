-module(solution).
-export([can_reach/2]).

can_reach(ArrList, Start) ->
    Arr = array:from_list(ArrList),
    N = array:size(Arr),
    Queue = queue:new(),
    Queue1 = queue:in(Start, Queue),
    Visited = gb_sets:new(),
    Visited1 = gb_sets:add(Start, Visited),
    bfs(Arr, N, Queue1, Visited1).

bfs(Arr, N, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true ->
            false;
        false ->
            {value, CurrentIdx, QueueOut} = queue:out(Queue),
            Value = array:get(CurrentIdx, Arr),
            if Value == 0 ->
                true;
            true ->
                NextIdx1 = CurrentIdx + Value,
                {QueueAfter1, VisitedAfter1} =
                    if NextIdx1 >= 0 andalso NextIdx1 < N andalso not gb_sets:is_element(NextIdx1, Visited) ->
                        {queue:in(NextIdx1, QueueOut), gb_sets:add(NextIdx1, Visited)};
                    true ->
                        {QueueOut, Visited}
                    end,

                NextIdx2 = CurrentIdx - Value,
                {QueueAfter2, VisitedAfter2} =
                    if NextIdx2 >= 0 andalso NextIdx2 < N andalso not gb_sets:is_element(NextIdx2, VisitedAfter1) ->
                        {queue:in(NextIdx2, QueueAfter1), gb_sets:add(NextIdx2, VisitedAfter1)};
                    true ->
                        {QueueAfter1, VisitedAfter1}
                    end,
                bfs(Arr, N, QueueAfter2, VisitedAfter2)
            end
    end.