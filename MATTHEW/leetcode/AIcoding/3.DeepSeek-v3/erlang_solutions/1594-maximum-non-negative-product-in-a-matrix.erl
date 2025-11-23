-spec max_product_path(Grid :: [[integer()]]) -> integer().
max_product_path(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = lists:duplicate(Rows, lists:duplicate(Cols, {0, 0})),
    {FirstVal, _} = lists:nth(1, lists:nth(1, Grid)),
    InitialDP = set_dp(1, 1, {FirstVal, FirstVal}, DP),
    UpdatedDP = fill_dp(1, 1, Grid, InitialDP),
    {Max, Min} = get_dp(Rows, Cols, UpdatedDP),
    if
        Max < 0 -> -1;
        true -> Max rem 1000000007
    end.

set_dp(Row, Col, Val, DP) ->
    RowList = lists:nth(Row, DP),
    NewRowList = setelement(Col, list_to_tuple(RowList), Val),
    setelement(Row, list_to_tuple(DP), tuple_to_list(NewRowList)).

get_dp(Row, Col, DP) ->
    RowList = lists:nth(Row, DP),
    lists:nth(Col, RowList).

fill_dp(Row, Col, Grid, DP) when Row =:= length(Grid), Col =:= length(hd(Grid)) ->
    DP;
fill_dp(Row, Col, Grid, DP) ->
    {CurrentMax, CurrentMin} = get_dp(Row, Col, DP),
    NextPositions = [{Row + 1, Col}, {Row, Col + 1}],
    NewDP = lists:foldl(fun({NextRow, NextCol}, AccDP) ->
        case NextRow =< length(Grid) andalso NextCol =< length(hd(Grid)) of
            true ->
                Value = lists:nth(NextCol, lists:nth(NextRow, Grid)),
                NewMax = max(CurrentMax * Value, CurrentMin * Value),
                NewMin = min(CurrentMax * Value, CurrentMin * Value),
                {ExistingMax, ExistingMin} = get_dp(NextRow, NextCol, AccDP),
                UpdatedMax = if
                    NextRow =:= 1, NextCol > 1 -> NewMax;
                    NextCol =:= 1, NextRow > 1 -> NewMax;
                    true -> max(NewMax, ExistingMax)
                end,
                UpdatedMin = if
                    NextRow =:= 1, NextCol > 1 -> NewMin;
                    NextCol =:= 1, NextRow > 1 -> NewMin;
                    true -> min(NewMin, ExistingMin)
                end,
                set_dp(NextRow, NextCol, {UpdatedMax, UpdatedMin}, AccDP);
            false ->
                AccDP
        end
    end, DP, NextPositions),
    if
        Row + 1 =< length(Grid) -> fill_dp(Row + 1, Col, Grid, NewDP);
        true -> fill_dp(1, Col + 1, Grid, NewDP)
    end.