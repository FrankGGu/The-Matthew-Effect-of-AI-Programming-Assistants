-module(painting_a_grid_with_three_different_colors).
-export([color_the_grid/2]).

color_the_grid(M, N) ->
    PossibleStates = possible_states(M),
    Matrix = create_matrix(PossibleStates),
    power_matrix(Matrix, N, length(PossibleStates)).

possible_states(M) ->
    possible_states_helper(M, []).

possible_states_helper(0, Acc) ->
    [lists:reverse(Acc)];
possible_states_helper(M, Acc) ->
    possible_states_helper(M - 1, [1 | Acc]) ++
    possible_states_helper(M - 1, [2 | Acc]) ++
    possible_states_helper(M - 1, [3 | Acc]).

create_matrix(PossibleStates) ->
    Len = length(PossibleStates),
    create_matrix_helper(PossibleStates, Len, []).

create_matrix_helper([], _, Acc) ->
    lists:reverse(Acc);
create_matrix_helper([State | Rest], Len, Acc) ->
    Row = [if is_valid_transition(State, Other) -> 1; true -> 0 end || Other <- PossibleStates],
    create_matrix_helper(Rest, Len, [Row | Acc]).

is_valid_transition(State1, State2) ->
    is_valid_transition_helper(State1, State2).

is_valid_transition_helper([], []) ->
    true;
is_valid_transition_helper([Color1 | Rest1], [Color2 | Rest2]) ->
    if Color1 == Color2 ->
        false;
    true ->
        is_valid_transition_helper(Rest1, Rest2)
    end.

power_matrix(Matrix, 1, Len) ->
    lists:foldl(fun(Row, Acc) -> (Acc + lists:sum(Row)) rem 1000000007 end, 0, Matrix);
power_matrix(Matrix, N, Len) when N > 1 ->
    HalfMatrix = power_matrix(Matrix, N div 2, Len),
    MultipliedMatrix = multiply_matrix(HalfMatrix, HalfMatrix, Len),
    if N rem 2 == 0 ->
        lists:foldl(fun(Row, Acc) -> (Acc + lists:sum(Row)) rem 1000000007 end, 0, MultipliedMatrix);
    true ->
        FinalMatrix = multiply_matrix(MultipliedMatrix, Matrix, Len),
        lists:foldl(fun(Row, Acc) -> (Acc + lists:sum(Row)) rem 1000000007 end, 0, FinalMatrix)
    end.

multiply_matrix(Matrix1, Matrix2, Len) ->
    Result = [[0 || _ <- lists:seq(1, Len)] || _ <- lists:seq(1, Len)],
    multiply_matrix_helper(Matrix1, Matrix2, Result, 1, 1, Len).

multiply_matrix_helper(Matrix1, Matrix2, Result, I, J, Len) when I > Len ->
    Result;
multiply_matrix_helper(Matrix1, Matrix2, Result, I, J, Len) when J > Len ->
    multiply_matrix_helper(Matrix1, Matrix2, Result, I + 1, 1, Len);
multiply_matrix_helper(Matrix1, Matrix2, Result, I, J, Len) ->
    Value = lists:foldl(fun(K, Acc) -> (Acc + (lists:nth(I, Matrix1) !! (K - 1) * lists:nth(K, Matrix2) !! (J - 1))) rem 1000000007 end, 0, lists:seq(1, Len)),
    multiply_matrix_helper(Matrix1, Matrix2, lists:replace_nth(I - 1, lists:replace_nth(J - 1, lists:nth(I, Result), Value), Result), I, J + 1, Len).