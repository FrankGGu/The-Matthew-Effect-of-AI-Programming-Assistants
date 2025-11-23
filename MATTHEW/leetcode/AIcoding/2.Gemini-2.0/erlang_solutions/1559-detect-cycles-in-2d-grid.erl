-module(detect_cycles_in_2d_grid).
-export([has_cycle/1]).

has_cycle(Grid) ->
    Rows = length(Grid),
    Cols = length(lists:nth(1, Grid)),
    Visited = array:new([Rows, Cols], false),

    lists:any(fun(Row) ->
                  lists:any(fun(Col) ->
                                 case array:get({Row, Col}, Visited) of
                                     false ->
                                         has_cycle_util(Grid, Visited, Row, Col, -1, -1);
                                     true ->
                                         false
                                 end
                             end, lists:seq(0, Cols - 1))
              end, lists:seq(0, Rows - 1)).

has_cycle_util(Grid, Visited, Row, Col, ParentRow, ParentCol) ->
    Rows = length(Grid),
    Cols = length(lists:nth(1, Grid)),

    if Row < 0 orelse Row >= Rows orelse Col < 0 orelse Col >= Cols then
        false
    else
        case array:get({Row, Col}, Visited) of
            true ->
                true;
            false ->
                array:set({Row, Col}, true, Visited),

                Val = lists:nth(Row + 1, Grid) !! Col;

                % Check up
                if Row > 0 andalso Row - 1 /= ParentRow andalso lists:nth(Row, Grid) !! Col == Val then
                    if has_cycle_util(Grid, Visited, Row - 1, Col, Row, Col) then
                        true
                    else

                        % Check left
                        if Col > 0 andalso Col - 1 /= ParentCol andalso lists:nth(Row + 1, Grid) !! (Col - 1) == Val then
                            if has_cycle_util(Grid, Visited, Row, Col - 1, Row, Col) then
                                true
                            else

                                % Check down
                                if Row < Rows - 1 andalso Row + 1 /= ParentRow andalso lists:nth(Row + 2, Grid) !! Col == Val then
                                    if has_cycle_util(Grid, Visited, Row + 1, Col, Row, Col) then
                                        true
                                    else

                                        % Check right
                                        if Col < Cols - 1 andalso Col + 1 /= ParentCol andalso lists:nth(Row + 1, Grid) !! (Col + 1) == Val then
                                            if has_cycle_util(Grid, Visited, Row, Col + 1, Row, Col) then
                                                true
                                            else
                                                false
                                            end
                                        else
                                            false
                                        end
                                    end
                                else
                                    false
                                end
                            end
                        else
                            false
                        end
                    end
                else

                    % Check left
                    if Col > 0 andalso Col - 1 /= ParentCol andalso lists:nth(Row + 1, Grid) !! (Col - 1) == Val then
                        if has_cycle_util(Grid, Visited, Row, Col - 1, Row, Col) then
                            true
                        else

                            % Check down
                            if Row < Rows - 1 andalso Row + 1 /= ParentRow andalso lists:nth(Row + 2, Grid) !! Col == Val then
                                if has_cycle_util(Grid, Visited, Row + 1, Col, Row, Col) then
                                    true
                                else

                                    % Check right
                                    if Col < Cols - 1 andalso Col + 1 /= ParentCol andalso lists:nth(Row + 1, Grid) !! (Col + 1) == Val then
                                        if has_cycle_util(Grid, Visited, Row, Col + 1, Row, Col) then
                                            true
                                        else
                                            false
                                        end
                                    else
                                        false
                                    end
                                end
                            else
                                false
                            end
                        end
                    else

                        % Check down
                        if Row < Rows - 1 andalso Row + 1 /= ParentRow andalso lists:nth(Row + 2, Grid) !! Col == Val then
                            if has_cycle_util(Grid, Visited, Row + 1, Col, Row, Col) then
                                true
                            else

                                % Check right
                                if Col < Cols - 1 andalso Col + 1 /= ParentCol andalso lists:nth(Row + 1, Grid) !! (Col + 1) == Val then
                                    if has_cycle_util(Grid, Visited, Row, Col + 1, Row, Col) then
                                        true
                                    else
                                        false
                                    end
                                else
                                    false
                                end
                            end
                        else

                            % Check right
                            if Col < Cols - 1 andalso Col + 1 /= ParentCol andalso lists:nth(Row + 1, Grid) !! (Col + 1) == Val then
                                if has_cycle_util(Grid, Visited, Row, Col + 1, Row, Col) then
                                    true
                                else
                                    false
                                end
                            else
                                false
                            end
                        end
                    end
                end
        end
    end.