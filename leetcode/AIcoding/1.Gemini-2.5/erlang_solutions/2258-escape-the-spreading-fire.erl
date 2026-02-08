-module(solution).
-export([maximumMinutes/1]).

-define(INFINITY, 1000000000). % A sufficiently large number for infinity

maximumMinutes(Grid) ->
    R = length(Grid),
    C = length(hd(Grid)),

    GridArray = list_to_array_of_arrays(Grid),

    FireArrivalTimesArray = calculate_fire_arrival_times(GridArray, R, C),

    % The maximum possible wait time can be bounded by the maximum possible fire arrival time
    % at any cell, which is R*C (max path length for fire).
    % If the person waits longer than that, they might as well not move.
    MaxPossibleWaitTime = R * C,

    binary_search_iter(0, MaxPossibleWaitTime, -1, GridArray, R, C, FireArrivalTimesArray).

binary_search_iter(Low, High, Ans, GridArray, R, C, FireArrivalTimesArray) ->
    if Low > High ->
        Ans;
       true ->
        Mid = Low + (High - Low) div 2,
        case check_escape(Mid, GridArray, R, C, FireArrivalTimesArray) of
            true ->
                % Possible with Mid, try for more wait time
                binary_search_iter(Mid + 1, High, Mid, GridArray, R, C, FireArrivalTimesArray);
            false ->
                % Not possible with Mid, reduce wait time
                binary_search_iter(Low, Mid - 1, Ans, GridArray, R, C, FireArrivalTimesArray)
        end
    end.

calculate_fire_arrival_times(GridArray, R, C) ->
    InitialFATRows = lists:duplicate(R, array:from_list(lists:duplicate(C, ?INFINITY))),
    FireArrivalTimesArray = array:from_list(InitialFATRows),

    Q = queue:new(),

    {FinalQ, FinalFAT} = lists:foldl(fun(R_idx, Acc) ->
        {AccQ, AccFAT} = Acc,
        RowArray = array:get(R_idx, GridArray),
        lists:foldl(fun(C_idx, Acc2) ->
            {AccQ2, AccFAT2} = Acc2,
            CellVal = array:get(C_idx, RowArray),
            case CellVal of
                1 -> % Initial fire cell
                    {queue:in({{R_idx, C_idx}, 0}, AccQ2), set_grid_val_array(AccFAT2, R_idx, C_idx, 0)};
                _ -> Acc2
            end
        end, Acc, lists:seq(0, C-1))
    end, {Q, FireArrivalTimesArray}, lists:seq(0, R-1)),

    bfs_fire(FinalQ, FinalFAT, GridArray, R, C).

bfs_fire(Q, FireArrivalTimesArray, GridArray, R, C) ->
    if queue:is_empty(Q) ->
        FireArrivalTimesArray;
       true ->
        {{CurrR, CurrC}, Time} = element(1, queue:peek(Q)),
        Q1 = queue:drop(Q),

        Dirs = [{0,1}, {0,-1}, {1,0}, {-1,0}],

        {NewQ, NewFireArrivalTimesArray} = lists:foldl(fun({Dr, Dc}, Acc) ->
            {AccQ, AccFAT} = Acc,
            NextR = CurrR + Dr,
            NextC = CurrC + Dc,

            if NextR >= 0, NextR < R, NextC >= 0, NextC < C ->
                GridVal = get_grid_val_array(GridArray, NextR, NextC),
                case GridVal of
                    2 -> Acc; % Wall, cannot spread
                    _ ->
                        FireTimeAtNeighbor = get_grid_val_array(AccFAT, NextR, NextC),
                        IfTime = Time + 1,
                        if IfTime < FireTimeAtNeighbor ->
                            {queue:in({{NextR, NextC}, IfTime}, AccQ), set_grid_val_array(AccFAT, NextR, NextC, IfTime)};
                           true -> Acc
                        end
                end;
               true -> Acc
            end
        end, {Q1, FireArrivalTimesArray}, Dirs),
        bfs_fire(NewQ, NewFireArrivalTimesArray, GridArray, R, C)
    end.

check_escape(WaitTime, GridArray, R, C, FireArrivalTimesArray) ->
    InitialPATRows = lists:duplicate(R, array:from_list(lists:duplicate(C, ?INFINITY))),
    PersonArrivalTimesArray = array:from_list(InitialPATRows),

    % Grid[0][0] is guaranteed to be grass (0).
    % Check if fire reaches start cell at or before person starts.
    if get_grid_val_array(FireArrivalTimesArray, 0, 0) <= WaitTime -> false;
       true ->
            Q = queue:new(),
            Q1 = queue:in({{0, 0}, WaitTime}, Q),
            PersonArrivalTimes1 = set_grid_val_array(PersonArrivalTimesArray, 0, 0, WaitTime),

            bfs_person(Q1, PersonArrivalTimes1, GridArray, R, C, FireArrivalTimesArray)
    end.

bfs_person(Q, PersonArrivalTimesArray, GridArray, R, C, FireArrivalTimesArray) ->
    if queue:is_empty(Q) ->
        false; % Cannot reach target
       true ->
        {{CurrR, CurrC}, Time} = element(1, queue:peek(Q)),
        Q1 = queue:drop(Q),

        % If target reached
        if CurrR == R-1, CurrC == C-1 ->
            true;
           true ->
            Dirs = [{0,1}, {0,-1}, {1,0}, {-1,0}],

            {NewQ, NewPersonArrivalTimesArray} = lists:foldl(fun({Dr, Dc}, Acc) ->
                {AccQ, AccPAT} = Acc,
                NextR = CurrR + Dr,
                NextC = CurrC + Dc,
                NextTime = Time + 1,

                if NextR >= 0, NextR < R, NextC >= 0, NextC < C ->
                    GridVal = get_grid_val_array(GridArray, NextR, NextC),
                    case GridVal of
                        2 -> Acc; % Wall, cannot move
                        _ ->
                            PersonTimeAtNeighbor = get_grid_val_array(AccPAT, NextR, NextC),
                            if NextTime < PersonTimeAtNeighbor ->
                                % Check fire condition
                                FireTimeAtNeighbor = get_grid_val_array(FireArrivalTimesArray, NextR, NextC),

                                IsSafe = if NextR == R-1, NextC == C-1 ->
                                            % Target cell: person can arrive at same time as fire
                                            NextTime <= FireTimeAtNeighbor;
                                           true ->
                                            % Intermediate cell: person must arrive strictly before fire
                                            NextTime < FireTimeAtNeighbor
                                         end,

                                if IsSafe ->
                                    {queue:in({{NextR, NextC}, NextTime}, AccQ), set_grid_val_array(AccPAT, NextR, NextC, NextTime)};
                                   true -> Acc
                                end;
                               true -> Acc
                            end
                    end;
                   true -> Acc
                end
            end, {Q1, PersonArrivalTimesArray}, Dirs),
            bfs_person(NewQ, NewPersonArrivalTimesArray, GridArray, R, C, FireArrivalTimesArray)
        end
    end.

get_grid_val_array(GridArray, R_idx, C_idx) ->
    RowArray = array:get(R_idx, GridArray),
    array:get(C_idx, RowArray).

set_grid_val_array(GridArray, R_idx, C_idx, Val) ->
    RowArray = array:get(R_idx, GridArray),
    NewRowArray = array:set(C_idx, Val, RowArray),
    array:set(R_idx, NewRowArray, GridArray).

list_to_array_of_arrays(ListOfLists) ->
    RowArrays = [array:from_list(Row) || Row <- ListOfLists],
    array:from_list(RowArrays).