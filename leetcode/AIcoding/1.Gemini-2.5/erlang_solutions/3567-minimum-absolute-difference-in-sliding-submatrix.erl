-module(solution).
-export([min_absolute_difference_in_sliding_submatrix/3]).

get_element(GridArray, R, C) ->
    array:get(C, array:get(R, GridArray)).

init_state() ->
    #{ elements_tree => gb_trees:empty(), element_counts => maps:new(),
       diffs_tree => gb_trees:empty(), diff_counts => maps:new() }.

add_diff(Diff, State) ->
    DiffCounts = maps:get(diff_counts, State),
    NewCount = maps:get(Diff, DiffCounts, 0) + 1,
    NewDiffCounts = maps:put(Diff, NewCount, DiffCounts),
    NewDiffsTree =
        case NewCount of
            1 -> gb_trees:insert(Diff, true, maps:get(diffs_tree, State));
            _ -> maps:get(diffs_tree, State)
        end,
    State#{ diffs_tree => NewDiffsTree, diff_counts => NewDiffCounts }.

remove_diff(Diff, State) ->
    DiffCounts = maps:get(diff_counts, State),
    NewCount = maps:get(Diff, DiffCounts) - 1,
    NewDiffCounts = maps:put(Diff, NewCount, DiffCounts),
    NewDiffsTree =
        case NewCount of
            0 -> gb_trees:delete(Diff, maps:get(diffs_tree, State));
            _ -> maps:get(diffs_tree, State)
        end,
    State#{ diffs_tree => NewDiffsTree, diff_counts => NewDiffCounts }.

add_val(Val, State) ->
    ElementCounts = maps:get(element_counts, State),
    ElementsTree = maps:get(elements_tree, State),
    NewCount = maps:get(Val, ElementCounts, 0) + 1,
    NewElementCounts = maps:put(Val, NewCount, ElementCounts),
    NewState = State#{ element_counts => NewElementCounts },

    case NewCount of
        1 -> % First time seeing this value, update trees
            Prev = gb_trees:prev(Val, ElementsTree),
            Next = gb_trees:next(Val, ElementsTree),
            NewElementsTree = gb_trees:insert(Val, true, ElementsTree),
            NewState1 = NewState#{ elements_tree => NewElementsTree },

            NewState2 =
                case {Prev, Next} of
                    {{PVal, _}, {NVal, _}} ->
                        remove_diff(NVal - PVal, NewState1);
                    _ -> NewState1
                end,
            NewState3 =
                case Prev of
                    {PVal, _} -> add_diff(Val - PVal, NewState2);
                    _ -> NewState2
                end,
            case Next of
                {NVal, _} -> add_diff(NVal - Val, NewState3);
                _ -> NewState3
            end;
        _ -> % Value already exists, just update count
            NewState
    end.

remove_val(Val, State) ->
    ElementCounts = maps:get(element_counts, State),
    ElementsTree = maps:get(elements_tree, State),
    NewCount = maps:get(Val, ElementCounts) - 1,
    NewElementCounts = maps:put(Val, NewCount, ElementCounts),
    NewState = State#{ element_counts => NewElementCounts },

    case NewCount of
        0 -> % Last time seeing this value, update trees
            Prev = gb_trees:prev(Val, ElementsTree),
            Next = gb_trees:next(Val, ElementsTree),
            NewElementsTree = gb_trees:delete(Val, ElementsTree),
            NewState1 = NewState#{ elements_tree => NewElementsTree },

            NewState2 =
                case Prev of
                    {PVal, _} -> remove_diff(Val - PVal, NewState1);
                    _ -> NewState1
                end,
            NewState3 =
                case Next of
                    {NVal, _} -> remove_diff(NVal - Val, NewState2);
                    _ -> NewState2
                end,
            case {Prev, Next} of
                {{PVal, _}, {NVal, _}} ->
                    add_diff(NVal - PVal, NewState3);
                _ -> NewState3
            end;
        _ -> % Value still exists, just update count
            NewState
    end.

get_min_diff(State) ->
    ElementsTree = maps:get(elements_tree, State),
    case gb_trees:size(ElementsTree) of
        0 -> 0;
        1 -> 0;
        _ -> element(1, gb_trees:smallest(maps:get(diffs_tree, State)))
    end.

min_absolute_difference_in_sliding_submatrix(Grid, R, C) ->
    GridRows = length(Grid),
    GridCols = length(hd(Grid)),

    GridArray = array:from_list(lists:map(fun(Row) -> array:from_list(Row) end, Grid)),

    % Initialize the state for the top-left (0,0) submatrix
    InitialStateFor00 = init_state(),
    StateFor00 =
        lists:foldl(fun(RowIdx, AccState) ->
                        lists:foldl(fun(ColIdx, InnerAccState) ->
                                        Val = get_element(GridArray, RowIdx, ColIdx),
                                        add_val(Val, InnerAccState)
                                    end, AccState, lists:seq(0, C - 1))
                    end, InitialStateFor00, lists:seq(0, R - 1)),

    % Outer fold for RStart (rows)
    % Acc: {List_of_Result_Rows, State_of_first_cell_in_current_vertical_strip_for_prev_row}
    % For RStart=0, PrevRowFirstColState is StateFor00
    {FinalResultRows, _} =
        lists:foldl(fun(RStart, {AccResultRows, PrevRowFirstColState}) ->
            % Calculate CurrentRowFirstColState (state for (RStart, 0))
            CurrentRowFirstColState =
                case RStart of
                    0 -> PrevRowFirstColState; % This is StateFor00
                    _ ->
                        % Remove elements of row RStart-1 (from columns 0 to C-1)
                        StateAfterRemoveRow =
                            lists:foldl(fun(ColIdx, AccState) ->
                                            Val = get_element(GridArray, RStart - 1, ColIdx),
                                            remove_val(Val, AccState)
                                        end, PrevRowFirstColState, lists:seq(0, C - 1)),
                        % Add elements of row RStart+R-1 (from columns 0 to C-1)
                        lists:foldl(fun(ColIdx, AccState) ->
                                        Val = get_element(GridArray, RStart + R - 1, ColIdx),
                                        add_val(Val, AccState)
                                    end, StateAfterRemoveRow, lists:seq(0, C - 1))
                end,

            % Inner fold for CStart (columns)
            % Acc: {List_of_results_for_current_row, State_of_last_processed_cell_in_current_row}
            {CurrentRowResults, LastColState} =
                lists:foldl(fun(CStart, {AccRowResults, CurrentState}) ->
                    StateForThisCell =
                        case CStart of
                            0 -> CurrentRowFirstColState; % Use the precomputed state for (RStart, 0)
                            _ -> % Slide horizontally from (RStart, CStart-1) to (RStart, CStart)
                                % Remove elements of column CStart-1 (from rows RStart to RStart+R-1)
                                StateAfterRemoveCol =
                                    lists:foldl(fun(RowIdx, AccState) ->
                                                    Val = get_element(GridArray, RowIdx, CStart - 1),
                                                    remove_val(Val, AccState)
                                                end, CurrentState, lists:seq(RStart, RStart + R - 1)),
                                % Add elements of column CStart+C-1 (from rows RStart to RStart+R-1)
                                lists:foldl(fun(RowIdx, AccState) ->
                                                Val = get_element(GridArray, RowIdx, CStart + C - 1),
                                                add_val(Val, AccState)
                                            end, StateAfterRemoveCol, lists:seq(RStart, RStart + R - 1))
                        end,

                    MinDiff = get_min_diff(StateForThisCell),
                    {AccRowResults ++ [MinDiff], StateForThisCell}
                end, {[], CurrentRowFirstColState}, lists:seq(0, GridCols - C)), % Initial CurrentState for CStart=0 is CurrentRowFirstColState

            {AccResultRows ++ [CurrentRowResults], CurrentRowFirstColState} % Pass CurrentRowFirstColState to next RStart iteration as PrevRowFirstColState
        end, {[], StateFor00}, lists:seq(0, GridRows - R)),

    FinalResultRows.