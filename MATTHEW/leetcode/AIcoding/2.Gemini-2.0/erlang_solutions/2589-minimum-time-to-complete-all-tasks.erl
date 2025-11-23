-module(minimum_time_to_complete_all_tasks).
-export([min_available_duration/1]).

min_available_duration(tasks) ->
    SortedTasks = lists:sort(
        fun({E1, S1, D1}, {E2, S2, D2}) ->
            if E1 < E2 then
                true
            else if E1 == E2 then
                if S1 < S2 then
                    true
                else
                    false
                end
            else
                false
            end
        end,
        tasks
    ),
    min_available_duration_helper(SortedTasks, [], 0).

min_available_duration_helper([], _Occupied, Acc) ->
    Acc;
min_available_duration_helper([{End, Start, Duration} | Rest], Occupied, Acc) ->
    Needed = Duration - count_overlapped(Start, End, Occupied),
    if Needed > 0 then
        NewOccupied = occupy(Start, End, Needed, Occupied),
        min_available_duration_helper(Rest, NewOccupied, Acc + Needed)
    else
        min_available_duration_helper(Rest, Occupied, Acc)
    end.

count_overlapped(Start, End, Occupied) ->
    count_overlapped_helper(Start, End, Occupied, 0).

count_overlapped_helper(_, _, [], Acc) ->
    Acc;
count_overlapped_helper(Start, End, [{S, E} | Rest], Acc) ->
    if (S >= Start and S < End) or (E > Start and E <= End) or (Start >= S and End <= E) then
        count_overlapped_helper(Start, End, Rest, Acc + (min(End, E) - max(Start, S)))
    else
        count_overlapped_helper(Start, End, Rest, Acc)
    end.

occupy(Start, End, Needed, Occupied) ->
    occupy_helper(End, Start, Needed, Occupied).

occupy_helper(End, _, 0, Occupied) ->
    Occupied;
occupy_helper(End, Start, Needed, Occupied) ->
    Last = End - 1,
    case lists:member({Last, End}, Occupied) of
        true ->
            occupy_helper(End - 1, Start, Needed, Occupied);
        false ->
            occupy_helper(End - 1, Start, Needed - 1, [{Last, End} | Occupied])
    end.

min(A, B) ->
    if A < B then
        A
    else
        B
    end.

max(A, B) ->
    if A > B then
        A
    else
        B
    end.