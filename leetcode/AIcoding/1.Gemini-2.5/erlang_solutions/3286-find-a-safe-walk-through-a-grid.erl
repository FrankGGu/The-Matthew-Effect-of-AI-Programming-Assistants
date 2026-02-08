-module(solution).
-export([solve/1]).

solve(Grid) ->
    R = length(Grid),
    C = length(hd(Grid)),
    MaxDangerInGrid = find_max_danger(Grid),

    %% Initialize Ans with a value higher than any possible danger in the grid.
    %% This serves as an indicator that no path has been found yet.
    InitialAns = MaxDangerInGrid + 1, 

    Result = binary_search(0, MaxDangerInGrid, InitialAns, Grid, R, C),

    %% If Result is still InitialAns, it means no path was found within the valid danger range.
    %% In such a case, return -1 (a common convention for "no solution" in LeetCode).
    %% Otherwise, return the found minimum maximum danger.
    if Result > MaxDangerInGrid ->
        -1;
    else
        Result
    end.

binary_search(Low, High, Ans, Grid, R, C) ->
    if Low > High ->
        Ans;
    else
        Mid = Low + (High - Low) div 2,
        case check(Mid, Grid, R, C) of
            true ->
                %% A path exists with max danger <= Mid. Try to find a smaller K.
                binary_search(Low, Mid - 1, Mid, Grid, R, C);
            false ->
                %% No path exists with max danger <= Mid. Need to allow a larger K.
                binary_search(Mid + 1, High, Ans, Grid, R, C)
        end
    end.

check(K, Grid, R, C) ->
    Start = {0,0},
    Target = {R-1, C-1},

    %% BFS queue is implemented as a tuple {FrontList, BackList} for efficiency.
    %% FrontList holds elements to be processed, BackList holds newly added elements.
    %% When FrontList is empty, BackList is reversed and becomes the new FrontList.
    InitialQueue = {[Start], []},
    InitialVisited = gb_sets:add(Start, gb_sets:empty()),

    bfs(InitialQueue, InitialVisited, K, Grid, R, C, Target).

bfs({[], []}, _Visited, _K, _Grid, _R, _C, _Target) ->
    false; %% Queue is empty, target not reached
bfs({[], Back}, Visited, K, Grid, R, C, Target) ->
    %% Front list is empty, reverse Back list to become new Front
    bfs({lists:reverse(Back), []}, Visited, K, Grid, R, C, Target);
bfs({[{CurrR, CurrC} | RestFront], Back}, Visited, K, Grid, R, C, Target) ->
    if CurrR == element(1, Target), CurrC == element(2, Target) ->
        true; %% Target reached
    else
        Neighbors = [{CurrR+1, CurrC}, {CurrR-1, CurrC}, {CurrR, CurrC+1}, {CurrR, CurrC-1}],
        {NewQueueFront, NewQueueBack, NewVisited} = 
            add_valid_neighbors(Neighbors, K, Grid, R, C, RestFront, Back, Visited),
        bfs({NewQueueFront, NewQueueBack}, NewVisited, K, Grid, R, C, Target)
    end.

add_valid_neighbors([], _K, _Grid, _R, _C, Front, Back, Visited) ->
    {Front, Back, Visited};
add_valid_neighbors([{NR, NC} | RestNeighbors], K, Grid, R, C, Front, Back, Visited) ->
    if NR >= 0, NR < R, NC >= 0, NC < C,
       not gb_sets:is_element({NR, NC}, Visited) ->
        Val = get_grid_val(Grid, NR, NC),
        if Val =< K ->
            %% Valid neighbor: within bounds, not visited, and danger <= K.
            %% Add to the back of the queue and mark as visited.
            add_valid_neighbors(RestNeighbors, K, Grid, R, C, Front, [{NR, NC} | Back], gb_sets:add({NR, NC}, Visited));
        else
            %% Danger too high, skip this neighbor.
            add_valid_neighbors(RestNeighbors, K, Grid, R, C, Front, Back, Visited)
        end;
    else
        %% Out of bounds or already visited, skip this neighbor.
        add_valid_neighbors(RestNeighbors, K, Grid, R, C, Front, Back, Visited)
    end.

get_grid_val(Grid, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).

find_max_danger(Grid) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Val, InnerAcc) ->
            max(Val, InnerAcc)
        end, Acc, Row)
    end, 0, Grid).