-module(solution).
-export([nearestExit/2]).

nearestExit(Maze, Entrance) ->
    Rows = length(Maze),
    Cols = length(hd(Maze)),
    [ER, EC] = Entrance,

    get_char_fun = fun(R, C) ->
        if
            R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols ->
                lists:nth(C + 1, lists:nth(R + 1, Maze));
            true ->
                '+'
        end
    end,

    is_valid_fun = fun(R, C) ->
        R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols andalso get_char_fun(R, C) =/= '+'
    end,

    is_exit_fun = fun(R, C) ->
        get_char_fun(R, C) == '.' andalso
        (R == 0 orelse R == Rows - 1 orelse C == 0 orelse C == Cols - 1)
    end,

    Q0 = queue:in({[ER, EC], 0}, queue:new()),
    V0 = sets:add({ER, EC}, sets:new()),

    bfs(Q0, V0, Entrance, is_valid_fun, is_exit_fun).

bfs(Q, Visited, Entrance, IsValid, IsExit) ->
    if queue:is_empty(Q) ->
        -1;
    true ->
        {{[R, C], Steps}, Q1} = queue:out(Q),

        Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

        {NextQ, NextVisited, FoundSteps} = lists:foldl(
            fun({NextR, NextC}, {AccQ, AccVisited, AccFoundSteps}) ->
                if AccFoundSteps =/= -1 ->
                    {AccQ, AccVisited, AccFoundSteps};
                IsValid(NextR, NextC) andalso not sets:is_element({NextR, NextC}, AccVisited) ->
                    if IsExit(NextR, NextC) andalso not ([NextR, NextC] == Entrance) ->
                        {AccQ, AccVisited, Steps + 1};
                    true ->
                        NewQ_ = queue:in({[NextR, NextC], Steps + 1}, AccQ),
                        NewVisited_ = sets:add({NextR, NextC}, AccVisited),
                        {NewQ_, NewVisited_, -1}
                    end;
                true ->
                    {AccQ, AccVisited, -1}
                end
            end,
            {Q1, Visited, -1},
            Neighbors
        ),

        case FoundSteps of
            -1 ->
                bfs(NextQ, NextVisited, Entrance, IsValid, IsExit);
            _ ->
                FoundSteps
        end
    end.