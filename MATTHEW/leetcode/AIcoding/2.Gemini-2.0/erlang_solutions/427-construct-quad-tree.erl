-module(construct_quad_tree).
-export([construct_quad_tree/1]).

-type node() :: #{
    'val' => boolean(),
    'isLeaf' => boolean(),
    'topLeft' => node() | null,
    'topRight' => node() | null,
    'bottomLeft' => node() | null,
    'bottomRight' => node() | null
}.

construct_quad_tree(Grid) ->
    construct(Grid, 0, 0, length(Grid)).

construct(Grid, Row, Col, Length) ->
    case is_same_value(Grid, Row, Col, Length) of
        true ->
            #{'val' => lists:nth(Col+1, lists:nth(Row+1, Grid)) == 1, 'isLeaf' => true, 'topLeft' => null, 'topRight' => null, 'bottomLeft' => null, 'bottomRight' => null};
        false ->
            NewLength = Length div 2,
            #{'val' => true, 'isLeaf' => false,
              'topLeft' => construct(Grid, Row, Col, NewLength),
              'topRight' => construct(Grid, Row, Col + NewLength, NewLength),
              'bottomLeft' => construct(Grid, Row + NewLength, Col, NewLength),
              'bottomRight' => construct(Grid, Row + NewLength, Col + NewLength, NewLength)
             }
    end.

is_same_value(Grid, Row, Col, Length) ->
    FirstValue = lists:nth(Col+1, lists:nth(Row+1, Grid)),
    is_same_value_helper(Grid, Row, Col, Length, FirstValue).

is_same_value_helper(_, _, _, 0, _) ->
    true;
is_same_value_helper(Grid, Row, Col, Length, FirstValue) ->
    case check_region(Grid, Row, Col, Length, FirstValue) of
        true ->
            true;
        false ->
            false
    end.

check_region(Grid, Row, Col, Length, FirstValue) ->
    check_region_helper(Grid, Row, Col, Length, FirstValue, 0, 0).

check_region_helper(_, _, _, 0, _, _, _) ->
    true;
check_region_helper(Grid, Row, Col, Length, FirstValue, CurrRow, CurrCol) ->
    case lists:nth(Col + CurrCol + 1, lists:nth(Row + CurrRow + 1, Grid)) == FirstValue of
        true ->
            case CurrCol + 1 == Length of
                true ->
                    case CurrRow + 1 == Length of
                        true ->
                            true;
                        false ->
                            check_region_helper(Grid, Row, Col, Length, FirstValue, CurrRow + 1, 0)
                    end;
                false ->
                    check_region_helper(Grid, Row, Col, Length, FirstValue, CurrRow, CurrCol + 1)
            end;
        false ->
            false
    end.