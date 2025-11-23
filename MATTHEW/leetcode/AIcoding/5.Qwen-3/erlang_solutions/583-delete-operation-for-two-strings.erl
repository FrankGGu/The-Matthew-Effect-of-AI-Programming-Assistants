-module(delete_operation_for_two_strings).
-export([min_distance/2]).

min_distance(A, B) ->
    N = length(A),
    M = length(B),
    DP = array:new(N+1, {default, 0}),
    DP1 = array:update(0, array:new(M+1, {default, 0}), DP),
    min_distance(A, B, 0, 0, DP1).

min_distance(_, _, N, _, _) when N == length(A) ->
    array:get(0, array:get(N, DP1));
min_distance(_, _, _, M, _) when M == length(B) ->
    array:get(0, array:get(N, DP1));
min_distance(A, B, I, J, DP) ->
    case array:get(I, DP) of
        Row ->
            Current = array:get(J, Row),
            if
                I == 0 -> 
                    NewRow = array:set(J+1, J+1, Row),
                    min_distance(A, B, I, J+1, array:set(I, NewRow, DP));
                J == 0 ->
                    NewRow = array:set(J+1, I+1, Row),
                    min_distance(A, B, I, J+1, array:set(I, NewRow, DP));
                true ->
                    case lists:nth(I+1, A) == lists:nth(J+1, B) of
                        true ->
                            NewVal = array:get(J, array:get(I-1, DP)),
                            NewRow = array:set(J+1, NewVal, Row),
                            min_distance(A, B, I, J+1, array:set(I, NewRow, DP));
                        false ->
                            Up = array:get(J, array:get(I-1, DP)),
                            Left = array:get(J+1, array:get(I, DP)),
                            Diag = array:get(J, array:get(I-1, DP)),
                            Min = min(min(Up, Left), Diag),
                            NewVal = Min + 1,
                            NewRow = array:set(J+1, NewVal, Row),
                            min_distance(A, B, I, J+1, array:set(I, NewRow, DP))
                    end
            end
    end.