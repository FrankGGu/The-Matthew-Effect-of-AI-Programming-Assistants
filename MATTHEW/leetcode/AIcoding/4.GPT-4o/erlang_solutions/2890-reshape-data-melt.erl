-module(reshape_data).
-export([reshape/3]).

reshape(Matrix, r, c) ->
    Rows = lists:flatten(Matrix),
    case length(Rows) of
        N when N == r * c ->
            reshape_helper(Rows, r, c, []);
        _ ->
            []
    end.

reshape_helper([], _, _, Acc) ->
    lists:reverse(Acc);
reshape_helper(Rows, R, C, Acc) ->
    {Row, Rest} = lists:split(C, Rows),
    reshape_helper(Rest, R - 1, C, [Row | Acc]).