-module(solution).
-export([reconstruct_matrix/3]).

-spec reconstruct_matrix(Upper :: integer(), Lower :: integer(), Colsum :: [integer()]) -> [[integer()]].
reconstruct_matrix(Upper, Lower, Colsum) ->
    reconstruct_matrix_helper(Upper, Lower, Colsum, [], []).

reconstruct_matrix_helper(0, 0, [], AccRow1, AccRow2) ->
    [lists:reverse(AccRow1), lists:reverse(AccRow2)];
reconstruct_matrix_helper(_, _, [], _, _) ->
    [];
reconstruct_matrix_helper(CurrentUpper, CurrentLower, [ColsumHead | ColsumTail], AccRow1, AccRow2) ->
    case ColsumHead of
        0 ->
            reconstruct_matrix_helper(CurrentUpper, CurrentLower, ColsumTail, [0 | AccRow1], [0 | AccRow2]);
        1 ->
            if
                CurrentUpper > 0 ->
                    reconstruct_matrix_helper(CurrentUpper - 1, CurrentLower, ColsumTail, [1 | AccRow1], [0 | AccRow2]);
                CurrentLower > 0 ->
                    reconstruct_matrix_helper(CurrentUpper, CurrentLower - 1, ColsumTail, [0 | AccRow1], [1 | AccRow2]);
                true ->
                    []
            end;
        2 ->
            if
                CurrentUpper > 0 andalso CurrentLower > 0 ->
                    reconstruct_matrix_helper(CurrentUpper - 1, CurrentLower - 1, ColsumTail, [1 | AccRow1], [1 | AccRow2]);
                true ->
                    []
            end;
        _ ->
            []
    end.