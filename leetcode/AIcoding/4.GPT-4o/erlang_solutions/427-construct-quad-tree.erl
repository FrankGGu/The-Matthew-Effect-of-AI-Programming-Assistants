-module(solution).
-export([construct/1]).

-record(node, {
    val :: boolean(),
    is_leaf :: boolean(),
    top_left :: 'node' | null,
    top_right :: 'node' | null,
    bottom_left :: 'node' | null,
    bottom_right :: 'node' | null
}).

-spec construct([[integer()]]) -> #node{}.
construct(Grid) ->
    construct(Grid, 0, 0, length(Grid)).

construct(Grid, Row, Col, Size) ->
    case is_uniform(Grid, Row, Col, Size) of
        {true, V} ->
            #node{val = V =:= 1, is_leaf = true, top_left = null, top_right = null,
                  bottom_left = null, bottom_right = null};
        false ->
            Half = Size div 2,
            TopLeft = construct(Grid, Row, Col, Half),
            TopRight = construct(Grid, Row, Col + Half, Half),
            BottomLeft = construct(Grid, Row + Half, Col, Half),
            BottomRight = construct(Grid, Row + Half, Col + Half, Half),
            #node{val = true, is_leaf = false,
                  top_left = TopLeft, top_right = TopRight,
                  bottom_left = BottomLeft, bottom_right = BottomRight}
    end.

is_uniform(Grid, Row, Col, Size) ->
    First = get(Grid, Row, Col),
    is_uniform(Grid, Row, Col, Size, First).

is_uniform(_, _, _, 1, V) -> {true, V};
is_uniform(Grid, Row, Col, Size, V) ->
    check_uniform(Grid, Row, Col, Size, V).

check_uniform(Grid, Row, Col, Size, V) ->
    lists:all(fun(R) ->
        lists:all(fun(C) -> get(Grid, R, C) =:= V end,
                  lists:seq(Col, Col + Size - 1))
    end, lists:seq(Row, Row + Size - 1)) orelse false.

get(Grid, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).
