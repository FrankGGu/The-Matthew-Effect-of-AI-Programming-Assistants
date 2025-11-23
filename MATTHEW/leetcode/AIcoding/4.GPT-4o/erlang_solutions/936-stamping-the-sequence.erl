-module(solution).
-export([moves_to_stamp/2]).

moves_to_stamp(Stamp, Target) ->
    Stamps = string:to_list(Stamp),
    Targets = string:to_list(Target),
    St = length(Stamps),
    T = length(Targets),
    Visited = lists:duplicate(T, false),
    Result = moves_to_stamp_helper(Stamps, Targets, Visited, [], T, St, 0),
    lists:reverse(Result).

moves_to_stamp_helper(_, [], _, Acc, _, _, _) ->
    Acc;
moves_to_stamp_helper(Stamps, Targets, Visited, Acc, T, St, Count) ->
    case find_stamp(Stamps, Targets, Visited, T, St) of
        {ok, Index} ->
            NewVisited = mark_visited(Visited, Index, St),
            moves_to_stamp_helper(Stamps, Targets, NewVisited, [Index | Acc], T, St, Count + 1);
        error ->
            if Count == 0 -> [] ; true -> Acc end
    end.

find_stamp(Stamps, Targets, Visited, T, St) ->
    lists:foldl(fun(Index, Acc) ->
        if
            Acc =:= ok -> Acc;
            not lists:nth(Index + 1, Visited) -> 
                case can_stamp(Stamps, Targets, Index) of
                    true -> {ok, Index};
                    false -> Acc
                end
        end
    end, error, lists:seq(0, T - St)).

can_stamp(Stamps, Targets, Index) ->
    lists:foldl(fun({S, T}, Acc) ->
        if 
            Acc == false -> false;
            S == $? -> true;
            S == T -> Acc;
            true -> false
        end
    end, true, lists:zip(lists:sublist(Stamps, 1), lists:sublist(Targets, Index + 1, length(Stamps))).

mark_visited(Visited, Index, St) ->
    lists:map(fun({V, I}) -> if I >= Index, I < Index + St -> true; true -> V end end,
                lists:zip(Visited, lists:seq(Index, Index + St - 1)).