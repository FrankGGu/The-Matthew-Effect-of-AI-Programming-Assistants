-module(max_value_sum_by_placing_three_rooks).
-export([maximumValueSum/1]).

maximumValueSum(Board) ->
    N = length(Board),
    Max = -1,
    Rows = lists:seq(0, N-1),
    Cols = lists:seq(0, N-1),
    generate_all_combinations(Rows, Cols, [], Max).

generate_all_combinations([], _, _, Acc) ->
    Acc;
generate_all_combinations([R | Rs], Cols, Acc, Max) ->
    generate_all_combinations(Rs, Cols, Acc, Max, R, Cols).

generate_all_combinations(_, [], Acc, Max, _, _) ->
    Acc;
generate_all_combinations(Row, [C | Cs], Acc, Max, R, Cols) ->
    NewAcc = case Acc of
        -1 -> lists:nth(R+1, Board) -- lists:nth(C+1, Board);
        _ -> max(Acc, lists:nth(R+1, Board) -- lists:nth(C+1, Board))
    end,
    generate_all_combinations(Row, Cs, NewAcc, Max, R, Cols).

lists:nth(Index, List) when is_list(List) ->
    lists:nth(Index, List).

--(A, B) -> A - B.