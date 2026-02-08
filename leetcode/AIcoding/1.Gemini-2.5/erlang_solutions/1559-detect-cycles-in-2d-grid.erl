-module(solution).
-export([hasCycle/1]).

hasCycle(GridList) ->
    Rows = length(GridList),
    Cols = length(hd(GridList)),
    GridTuple = list_to_tuple([list_to_tuple(Row) || Row <- GridList]),
    InitialVisitedSet = sets:new(),
    check_all_cells(GridTuple, Rows, Cols, 0, 0, InitialVisitedSet).

check_all_cells(_GridTuple, Rows, _Cols, R, _C, _VisitedSet) when R >= Rows ->
    false;
check_all_cells(GridTuple, Rows, Cols, R, C, VisitedSet) when C >= Cols ->
    check_all_cells(GridTuple, Rows, Cols, R+1, 0, VisitedSet);
check_all_cells(GridTuple, Rows, Cols, R, C, VisitedSet) ->
    Char = get_char(GridTuple, R, C),
    case sets:is_element({R, C}, VisitedSet) of
        true ->
            check_all_cells(GridTuple, Rows, Cols, R, C+1, VisitedSet);
        false ->
            NewVisitedSet = sets:add_element({R, C}, VisitedSet),
            case dfs_explore(GridTuple, Rows, Cols, R, C, -1, -1, Char, NewVisitedSet) of
                {true, _FinalVisitedSet} ->
                    true;
                {false, FinalVisitedSet} ->
                    check_all_cells(GridTuple, Rows, Cols, R, C+1, FinalVisitedSet)
            end
    end.

dfs_explore(GridTuple, Rows, Cols, CurrentR, CurrentC, ParentR, ParentC, TargetChar, VisitedSet) ->
    Neighbors = [{CurrentR-1, CurrentC}, {CurrentR+1, CurrentC}, {CurrentR, CurrentC-1}, {CurrentR, CurrentC+1}],

    lists:foldl(fun({NR, NC}, {CycleFound, CurrentAccVisitedSet}) ->
        case CycleFound of
            true -> {true, CurrentAccVisitedSet};
            false ->
                case (NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols) of
                    false ->
                        {false, CurrentAccVisitedSet};
                    true ->
                        case get_char(GridTuple, NR, NC) == TargetChar of
                            false ->
                                {false, CurrentAccVisitedSet};
                            true ->
                                case ({NR, NC} == {ParentR, ParentC}) of
                                    true ->
                                        {false, CurrentAccVisitedSet};
                                    false ->
                                        case sets:is_element({NR, NC}, CurrentAccVisitedSet) of
                                            true ->
                                                {true, CurrentAccVisitedSet};
                                            false ->
                                                TempVisitedSet = sets:add_element({NR, NC}, CurrentAccVisitedSet),
                                                dfs_explore(GridTuple, Rows, Cols, NR, NC, CurrentR, CurrentC, TargetChar, TempVisitedSet)
                                        end
                                end
                        end
                end
        end
    end, {false, VisitedSet}, Neighbors).

get_char(GridTuple, R, C) ->
    element(C+1, element(R+1, GridTuple)).