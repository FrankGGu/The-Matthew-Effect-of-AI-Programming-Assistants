-module(solution).
-export([find_diagonal_order/1]).

find_diagonal_order(Mat) ->
    M = length(Mat),
    case M of
        0 -> [];
        _ ->
            N = length(hd(Mat)),
            case N of
                0 -> [];
                _ ->
                    TupleMat = list_to_tuple(lists:map(fun list_to_tuple/1, Mat)),
                    traverse(TupleMat, M, N, 0, M + N - 2, [])
            end
    end.

traverse(_TupleMat, _M, _N, CurrentSum, MaxSum, Acc) when CurrentSum > MaxSum ->
    lists:reverse(Acc);
traverse(TupleMat, M, N, CurrentSum, MaxSum, Acc) ->
    IsEven = (CurrentSum rem 2 == 0),

    MinI = erlang:max(0, CurrentSum - (N - 1)),
    MaxI = erlang:min(M - 1, CurrentSum),

    CurrentDiagonalAcc = 
        case IsEven of
            true ->
                lists:foldl(fun(I, DiagAcc) ->
                                J = CurrentSum - I,
                                Element = element(J + 1, element(I + 1, TupleMat)),
                                [Element | DiagAcc]
                            end, [], lists:seq(MaxI, MinI, -1));
            false ->
                lists:foldl(fun(I, DiagAcc) ->
                                J = CurrentSum - I,
                                Element = element(J + 1, element(I + 1, TupleMat)),
                                [Element | DiagAcc]
                            end, [], lists:seq(MinI, MaxI))
        end,

    traverse(TupleMat, M, N, CurrentSum + 1, MaxSum, lists:reverse(CurrentDiagonalAcc) ++ Acc).