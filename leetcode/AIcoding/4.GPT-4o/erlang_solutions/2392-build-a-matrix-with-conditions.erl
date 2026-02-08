-module(solution).
-export([buildMatrix/3]).

buildMatrix(N, rowConditions, colConditions) ->
    Row = lists:duplicate(N, 0),
    Col = lists:duplicate(N, 0),
    RowRef = lists:duplicate(N, []),
    ColRef = lists:duplicate(N, []),
    {Row, RowRef} = build_conditions(N, rowConditions, Row, RowRef, 1),
    {Col, ColRef} = build_conditions(N, colConditions, Col, ColRef, 1),
    Matrix = lists:map(fun(X) -> lists:map(fun(Y) -> if X =:= Y -> 1; true -> 0 end end, lists:seq(1, N)) end, lists:seq(1, N)),
    case validate_matrix(Matrix, Row, Col) of
        true -> Matrix;
        false -> []
    end.

build_conditions(_, [], Acc, Ref, _) -> {Acc, Ref};
build_conditions(N, [{X, Y} | Rest], Acc, Ref, Val) ->
    NewAcc = lists:update_at(X, fun(L) -> [Y | L] end, Acc),
    NewRef = lists:update_at(Y, fun(L) -> [X | L] end, Ref),
    build_conditions(N, Rest, NewAcc, NewRef, Val).

validate_matrix(_, [], _) -> true;
validate_matrix(Matrix, [Row | Rest], Col) ->
    case validate_row(Matrix, Row) of
        true -> validate_matrix(Matrix, Rest, Col);
        false -> false
    end.

validate_row(_, []) -> true;
validate_row(Matrix, [Y | Rest]) ->
    case lists:member(Y, lists:nth(Y, Matrix)) of
        true -> validate_row(Matrix, Rest);
        false -> false
    end.