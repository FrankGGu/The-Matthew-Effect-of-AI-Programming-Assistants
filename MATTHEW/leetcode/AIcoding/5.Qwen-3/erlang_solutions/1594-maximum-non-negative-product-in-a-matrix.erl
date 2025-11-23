-module(max_non_negative_product).
-export([maxProductPath/1]).

maxProductPath(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Max = -1,
    Min = 1,
    DP = array:new({0, Rows-1}, {0, Cols-1}, 0),
    DP2 = array:new({0, Rows-1}, {0, Cols-1}, 0),
    DP3 = array:new({0, Rows-1}, {0, Cols-1}, 0),
    maxProductPath(Matrix, 0, 0, Rows, Cols, DP, DP2, DP3).

maxProductPath(_, _, Cols, _, Cols, DP, DP2, DP3) ->
    array:get(0, 0, DP);
maxProductPath(_, Rows, _, Rows, _, DP, DP2, DP3) ->
    array:get(0, 0, DP);
maxProductPath(Matrix, Row, Col, Rows, Cols, DP, DP2, DP3) ->
    Val = lists:nth(Row+1, Matrix) -- [Col],
    if
        Row == 0 andalso Col == 0 ->
            NewMax = Val,
            NewMin = Val,
            DP1 = array:set(Row, Col, NewMax, DP),
            DP21 = array:set(Row, Col, NewMin, DP2),
            maxProductPath(Matrix, Row, Col+1, Rows, Cols, DP1, DP21, DP3);
        Row == 0 ->
            PrevMax = array:get(Row, Col-1, DP),
            PrevMin = array:get(Row, Col-1, DP2),
            CurrentMax = max(PrevMax * Val, PrevMin * Val),
            CurrentMin = min(PrevMax * Val, PrevMin * Val),
            DP1 = array:set(Row, Col, CurrentMax, DP),
            DP21 = array:set(Row, Col, CurrentMin, DP2),
            maxProductPath(Matrix, Row, Col+1, Rows, Cols, DP1, DP21, DP3);
        Col == 0 ->
            PrevMax = array:get(Row-1, Col, DP),
            PrevMin = array:get(Row-1, Col, DP2),
            CurrentMax = max(PrevMax * Val, PrevMin * Val),
            CurrentMin = min(PrevMax * Val, PrevMin * Val),
            DP1 = array:set(Row, Col, CurrentMax, DP),
            DP21 = array:set(Row, Col, CurrentMin, DP2),
            maxProductPath(Matrix, Row+1, Col, Rows, Cols, DP1, DP21, DP3);
        true ->
            UpMax = array:get(Row-1, Col, DP),
            UpMin = array:get(Row-1, Col, DP2),
            LeftMax = array:get(Row, Col-1, DP),
            LeftMin = array:get(Row, Col-1, DP2),
            CurrentMax = max(max(UpMax * Val, UpMin * Val), max(LeftMax * Val, LeftMin * Val)),
            CurrentMin = min(min(UpMax * Val, UpMin * Val), min(LeftMax * Val, LeftMin * Val)),
            DP1 = array:set(Row, Col, CurrentMax, DP),
            DP21 = array:set(Row, Col, CurrentMin, DP2),
            maxProductPath(Matrix, Row, Col+1, Rows, Cols, DP1, DP21, DP3)
    end.