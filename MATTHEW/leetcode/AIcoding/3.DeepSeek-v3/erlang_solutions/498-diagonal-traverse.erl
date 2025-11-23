-spec find_diagonal_order(Mat :: [[integer()]]) -> [integer()].
find_diagonal_order(Mat) ->
    case Mat of
        [] -> [];
        _ ->
            M = length(Mat),
            N = length(hd(Mat)),
            lists:reverse(lists:foldl(fun(I, Acc) -> 
                case I rem 2 of
                    0 -> lists:reverse(get_diagonal(Mat, I, 0, M, N)) ++ Acc;
                    1 -> get_diagonal(Mat, I, 0, M, N) ++ Acc
                end
            end, [], lists:seq(0, M + N - 2)))
    end.

get_diagonal(Mat, I, J, M, N) ->
    Row = lists:seq(max(0, I - N + 1), min(I, M - 1)),
    Col = lists:seq(min(I, N - 1), max(0, I - M + 1), -1),
    lists:map(fun({R, C}) -> lists:nth(C + 1, lists:nth(R + 1, Mat)) end, lists:zip(Row, Col)).