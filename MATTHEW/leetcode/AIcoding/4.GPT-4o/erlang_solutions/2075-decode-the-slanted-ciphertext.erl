decodeCiphertext(Ciphertext, Rows) ->
    Cols = length(Ciphertext) div Rows,
    Result = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Col, Acc2) ->
            case lists:nth(Row * Cols + Col + 1, Ciphertext) of
                $\s -> Acc2;
                Char -> Acc2 ++ [Char]
            end
        end, Acc, lists:seq(0, Cols - 1))
    end, [], lists:seq(0, Rows - 1)),
    lists:flatten(Result).