-module(broken_board_dominoes).
-export([max_dominoes/1]).

-define(DIRS, [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]).

dfs(U_Node, Visited, MatchR, Adj) ->
    case dict:is_key(U_Node, Visited) of
        true -> {false, MatchR};
        false ->
            NewVisited = dict:store(U_Node, true, Visited),
            Neighbors = dict:get(U_Node, Adj, []),
            lists:foldl(fun(V_Node, {FoundPath, CurrentMatchR}) ->
                                case FoundPath of
                                    true -> {true, CurrentMatchR};
                                    false ->
                                        case dict:is_key(V_Node, CurrentMatchR) of
                                            false ->
                                                {true, dict:store(V_Node, U_Node, CurrentMatchR)};
                                            true ->
                                                U_Prev = dict:get(V_Node, CurrentMatchR),
                                                case dfs(U_Prev, NewVisited, CurrentMatchR, Adj) of
                                                    {true, UpdatedMatchR} ->
                                                        {true, dict:store(V_Node, U_Node, UpdatedMatchR)};
                                                    {false, _} ->
                                                        {false, CurrentMatchR}
                                                end
                                        end
                                end
                        end, {false, MatchR}, Neighbors)
    end.

max_dominoes(Board) ->
    R = length(Board),
    C = length(hd(Board)),

    {LeftNodesAcc, RightNodesSetAcc, UsableCellsSetAcc, _} =
        lists:foldl(fun(Row, {AccLeft, AccRightSet, AccUsableSet, CurrentR}) ->
            {NewAccLeft, NewAccRightSet, NewAccUsableSet, _} =
                lists:foldl(fun(CellVal, {AccLeft2, AccRightSet2, AccUsableSet2, CurrentC}) ->
                    case CellVal of
                        1 ->
                            Cell = {CurrentR, CurrentC},
                            Parity = (CurrentR + CurrentC) rem 2,
                            NewUsableSet = gb_sets:add(Cell, AccUsableSet2),
                            case Parity of
                                0 -> {[Cell | AccLeft2], AccRightSet2, NewUsableSet, CurrentC + 1};
                                1 -> {AccLeft2, gb_sets:add(Cell, AccRightSet2), NewUsableSet, CurrentC + 1}
                            end;
                        _ ->
                            {AccLeft2, AccRightSet2, AccUsableSet2, CurrentC + 1}
                    end
                end, {AccLeft, AccRightSet, AccUsableSet, 0}, Row),
            {NewAccLeft, NewAccRightSet, NewAccUsableSet, CurrentR + 1}
        end, {[], gb_sets:new(), gb_sets:new(), 0}, Board),

    LeftNodesList = lists:reverse(LeftNodesAcc),
    RightNodesSet = RightNodesSetAcc,

    Adj = lists:foldl(fun(U_Node={Ur, Uc}, AccAdj) ->
        Neighbors = lists:filtermap(fun({Dr, Dc}) ->
            Nr = Ur + Dr,
            Nc = Uc + Dc,
            case (Nr >= 0 andalso Nr < R andalso Nc >= 0 andalso Nc < C) of
                true ->
                    NeighborCell = {Nr, Nc},
                    case gb_sets:is_member(NeighborCell, RightNodesSet) of
                        true -> {true, NeighborCell};
                        false -> false
                    end;
                false -> false
            end
        end, ?DIRS),
        dict:store(U_Node, Neighbors, AccAdj)
    end, dict:new(), LeftNodesList),

    InitialMatchR = dict:new(),
    TotalMatches = lists:foldl(fun(U_Node, AccMatches) ->
        {FoundPath, UpdatedMatchR} = dfs(U_Node, dict:new(), AccMatches, Adj),
        case FoundPath of
            true -> AccMatches + 1;
            false -> AccMatches
        end
    end, 0, LeftNodesList),

    TotalMatches.