%% -spec spiral_order(Matrix :: [[integer()]]) -> [integer()].
spiral_order(Matrix) ->
    spiral_order(Matrix, [], {0, 0}, {length(Matrix) - 1, length(hd(Matrix)) - 1}).

spiral_order(_, Result, {Row, _}, {Row, Col}) when Row == Col ->
    lists:reverse(Result);
spiral_order(Matrix, Result, {Row, Col}, {MaxRow, MaxCol}) when Row == MaxRow ->
    spiral_order(Matrix, Result ++ lists:sublist(Matrix, Col + 1, MaxCol - Col), {Row + 1, Col}, {MaxRow, MaxCol});
spiral_order(Matrix, Result, {Row, Col}, {MaxRow, MaxCol}) when Col == MaxCol ->
    spiral_order(Matrix, Result ++ [hd(lists:nthtail(Row, Matrix))], {Row, Col - 1}, {MaxRow, MaxCol - 1});
spiral_order(Matrix, Result, {Row, Col}, {MaxRow, MaxCol}) ->
    spiral_order(Matrix, Result ++ [hd(Matrix)], {Row + 1, Col}, {MaxRow, MaxCol - 1}).
