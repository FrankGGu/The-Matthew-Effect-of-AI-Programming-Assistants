-module(all_divisions).
-export([max_score_indices/1]).

max_score_indices(Nums) ->
    {N, Ones, Zeros} = lists:foldl(
        fun(Num, {AccN, AccOnes, AccZeros}) ->
            case Num of
                0 -> {AccN + 1, AccOnes, AccZeros + 1};
                1 -> {AccN + 1, AccOnes + 1, AccZeros}
            end
        end,
        {0, 0, 0},
        Nums
    ),
    Indices = lists:seq(0, N),
    Scores = [calculate_score(Index, Nums, Ones) || Index <- Indices],
    MaxScore = lists:max(Scores),
    [Index || {Index, Score} <- lists:zip(Indices, Scores), Score =:= MaxScore].

calculate_score(Index, Nums, Ones) ->
    LeftZeros = calculate_left_zeros(Index, Nums),
    RightOnes = Ones - calculate_left_ones(Index, Nums),
    LeftZeros + RightOnes.

calculate_left_zeros(Index, Nums) ->
    lists:foldl(
        fun(Num, Acc) ->
            case Num of
                0 -> Acc + 1;
                1 -> Acc
            end
        end,
        0,
        lists:sublist(Nums, Index)
    ).

calculate_left_ones(Index, Nums) ->
    lists:foldl(
        fun(Num, Acc) ->
            case Num of
                0 -> Acc;
                1 -> Acc + 1
            end
        end,
        0,
        lists:sublist(Nums, Index)
    ).