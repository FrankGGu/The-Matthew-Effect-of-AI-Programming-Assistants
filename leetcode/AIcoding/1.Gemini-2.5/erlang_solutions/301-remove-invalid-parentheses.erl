-module(solution).
-export([removeInvalidParentheses/1]).

is_valid(S) ->
    is_valid(S, 0).

is_valid([], 0) -> true;
is_valid([], _) -> false;
is_valid([$( | T], Balance) -> is_valid(T, Balance + 1);
is_valid([$) | T], Balance) when Balance > 0 -> is_valid(T, Balance - 1);
is_valid([$) | _], 0) -> false;
is_valid([_ | T], Balance) -> is_valid(T, Balance).

removeInvalidParentheses(S) ->
    Q = queue:new(),
    Q1 = queue:in(S, Q),
    Visited = sets:new(),
    Visited1 = sets:add_element(S, Visited),

    bfs_search(Q1, Visited1, []).

bfs_search(Q, Visited, FoundResults) ->
    if queue:is_empty(Q) ->
        lists:usort(FoundResults);
    else
        LevelSize = queue:len(Q),
        {NextQ, NextVisited, CurrentLevelValidStrings, FoundInThisLevel} =
            process_current_level(Q, queue:new(), Visited, [], false, LevelSize),

        if FoundInThisLevel ->
            lists:usort(lists:reverse(CurrentLevelValidStrings));
        else
            bfs_search(NextQ, NextVisited, [])
        end
    end.

process_current_level(CurrentQ, NextQAcc, VisitedAcc, CurrentLevelValidStringsAcc, FoundInThisLevelAcc, 0) ->
    {NextQAcc, VisitedAcc, CurrentLevelValidStringsAcc, FoundInThisLevelAcc};

process_current_level(CurrentQ, NextQAcc, VisitedAcc, CurrentLevelValidStringsAcc, FoundInThisLevelAcc, Count) ->
    {value, S, Q_tail} = queue:out(CurrentQ),

    case is_valid(S) of
        true ->
            process_current_level(Q_tail, NextQAcc, VisitedAcc, [S | CurrentLevelValidStringsAcc], true, Count - 1);
        false when FoundInThisLevelAcc ->
            process_current_level(Q_tail, NextQAcc, VisitedAcc, CurrentLevelValidStringsAcc, FoundInThisLevelAcc, Count - 1);
        false ->
            {NewNextQAcc, NewVisitedAcc} = generate_children(S, NextQAcc, VisitedAcc),
            process_current_level(Q_tail, NewNextQAcc, NewVisitedAcc, CurrentLevelValidStringsAcc, FoundInThisLevelAcc, Count - 1)
    end.

generate_children(S, NextQAcc, VisitedAcc) ->
    lists:foldl(fun(I, {AccQ, AccVisited}) ->
        Char = lists:nth(I + 1, S),
        if Char == $(; Char == $) ->
            NextS = lists:sublist(S, 1, I) ++ lists:nthtail(I + 2, S),
            if not sets:is_element(NextS, AccVisited) ->
                {queue:in(NextS, AccQ), sets:add_element(NextS, AccVisited)};
            else
                {AccQ, AccVisited}
            end;
        true ->
            {AccQ, AccVisited}
        end
    end, {NextQAcc, VisitedAcc}, lists:seq(0, length(S) - 1)).