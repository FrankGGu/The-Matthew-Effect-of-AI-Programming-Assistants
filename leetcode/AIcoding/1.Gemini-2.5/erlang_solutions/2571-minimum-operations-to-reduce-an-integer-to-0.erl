-module(solution).
-export([min_operations/1]).

-spec min_operations(N :: integer()) -> integer().
min_operations(N) ->
    if N == 0 ->
        0;
    true ->
        Q = queue:from_list([{N, 0}]),
        Visited = sets:new(),
        Visited1 = sets:add_element(N, Visited),
        bfs(Q, Visited1)
    end.

bfs(Q, Visited) ->
    {{value, {CurrentNum, Steps}}, NewQ} = queue:out(Q),

    if CurrentNum == 0 ->
        Steps;
    true ->
        NextStates1 = [],

        NextNum1 = CurrentNum - 1,
        NextStates_Minus1 = if NextNum1 >= 0 andalso not sets:is_element(NextNum1, Visited) ->
                          [{NextNum1, Steps + 1}];
                      true ->
                          []
                      end,

        NextNum2 = CurrentNum + 1,
        NextStates_Plus1 = if not sets:is_element(NextNum2, Visited) ->
                          [{NextNum2, Steps + 1}];
                      true ->
                          []
                      end,

        NextStates_Div2 = if CurrentNum rem 2 == 0 andalso not sets:is_element(CurrentNum div 2, Visited) ->
                          [{CurrentNum div 2, Steps + 1}];
                      true ->
                          []
                      end,

        AllNextStates = NextStates_Minus1 ++ NextStates_Plus1 ++ NextStates_Div2,

        {UpdatedQ, UpdatedVisited} = lists:foldl(
            fun({Num, S}, {AccQ, AccVisited}) ->
                {queue:in({Num, S}, AccQ), sets:add_element(Num, AccVisited)}
            end,
            {NewQ, Visited},
            AllNextStates
        ),

        bfs(UpdatedQ, UpdatedVisited)
    end.