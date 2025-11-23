-module(maximum_rook_sum1).
-export([max_sum_after_placing_rooks/1]).

max_sum_after_placing_rooks(Matrix) ->
    N = length(Matrix),
    max_sum_after_placing_rooks_helper(Matrix, 0, 0, 0, 0, 0, 0, N).

max_sum_after_placing_rooks_helper(Matrix, R1, C1, R2, C2, R3, C3, N) ->
    if R1 >= N orelse R2 >= N orelse R3 >= N then
        -1
    else
        case {R1, C1, R2, C2, R3, C3} of
            {0, 0, 0, 0, 0, 0} ->
                lists:max([
                    max_sum_after_placing_rooks_helper(Matrix, I1, J1, I2, J2, I3, J3, N)
                    || I1 <- lists:seq(0, N - 1), J1 <- lists:seq(0, N - 1),
                       I2 <- lists:seq(0, N - 1), J2 <- lists:seq(0, N - 1),
                       I3 <- lists:seq(0, N - 1), J3 <- lists:seq(0, N - 1),
                       (I1 /= I2 orelse J1 /= J2) ,
                       (I1 /= I3 orelse J1 /= J3) ,
                       (I2 /= I3 orelse J2 /= J3)
                ]) + Matrix !! 0 !! 0;
            _ ->
                Value1 = get_element(Matrix, R1, C1, N),
                Value2 = get_element(Matrix, R2, C2, N),
                Value3 = get_element(Matrix, R3, C3, N),

                if Value1 == -1 orelse Value2 == -1 orelse Value3 == -1 then
                    -1
                else
                    Value1 + Value2 + Value3
                end
        end
    end.

get_element(Matrix, Row, Col, N) ->
    if Row >= 0 and Row < N and Col >= 0 and Col < N then
        Matrix !! Row !! Col
    else
        -1
    end.