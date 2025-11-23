-spec valid_square(Matrix :: [[integer()]]) -> boolean().
valid_square(Matrix) ->
    N = length(Matrix),
    Check = lists:seq(1, N),
    RowsValid = lists:all(fun(Row) -> lists:sort(Row) =:= Check end, Matrix),
    ColsValid = lists:all(fun(Col) -> lists:sort(Col) =:= Check end, transpose(Matrix)),
    RowsValid andalso ColsValid.

transpose(Matrix) ->
    transpose(Matrix, []).

transpose([[]|_], Acc) ->
    lists:reverse(Acc);
transpose(Matrix, Acc) ->
    {Heads, Tails} = lists:foldl(fun([H|T], {Hs, Ts}) -> {[H|Hs], [T|Ts]} end, {[], []}, Matrix),
    transpose(lists:reverse(Tails), [lists:reverse(Heads)|Acc]).