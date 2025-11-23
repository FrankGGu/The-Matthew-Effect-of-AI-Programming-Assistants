-module(solution).
-export([delete_columns_to_make_sorted_iii/1]).

delete_columns_to_make_sorted_iii(Words) ->
    M = length(hd(Words)),
    WordsTuples = lists:map(fun list_to_tuple/1, Words),

    InitialDP = lists:duplicate(M, 1),

    FinalDP = lists:foldl(
        fun(J, AccDP) ->
            calculate_dp_for_j(J, AccDP, WordsTuples)
        end,
        InitialDP,
        lists:seq(0, M-1)
    ),

    MaxKeptColumns = lists:max(FinalDP),
    M - MaxKeptColumns.

calculate_dp_for_j(J, DP, WordsTuples) ->
    CurrentMaxForJ = lists:foldl(
        fun(I, AccMax) ->
            case can_precede(I, J, WordsTuples) of
                true ->
                    max(AccMax, 1 + lists:nth(I + 1, DP));
                false ->
                    AccMax
            end
        end,
        1,
        lists:seq(0, J - 1)
    ),
    lists:replace_nth(J + 1, CurrentMaxForJ, DP).

can_precede(ColIdx1, ColIdx2, WordsTuples) ->
    lists:all(
        fun(WordTuple) ->
            element(ColIdx1 + 1, WordTuple) =< element(ColIdx2 + 1, WordTuple)
        end,
        WordsTuples
    ).