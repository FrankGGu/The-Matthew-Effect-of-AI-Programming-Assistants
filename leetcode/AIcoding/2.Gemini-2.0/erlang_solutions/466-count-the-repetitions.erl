-module(count_repetitions).
-export([get_max_repetitions/3]).

get_max_repetitions(S1, N1, S2) ->
    get_max_repetitions(S1, N1, S2, 0, 0, [], []).

get_max_repetitions(S1, N1, S2, S1Count, S2Count, SeenS1, SeenS2) when S1Count >= N1 ->
    S2Count div N1;
get_max_repetitions(S1, N1, S2, S1Count, S2Count, SeenS1, SeenS2) ->
    case lists:member(S1Count rem length(S1), SeenS1) of
        true ->
            Index = lists:index(S1Count rem length(S1), SeenS1),
            PrevS1Count = lists:nth(Index, SeenS1),
            PrevS2Count = lists:nth(Index, SeenS2),
            CycleS1 = S1Count - PrevS1Count,
            CycleS2 = S2Count - PrevS2Count,
            RemainingS1 = N1 - S1Count,
            Times = RemainingS1 div CycleS1,
            S2CountFinal = S2Count + Times * CycleS2,
            S1CountFinal = S1Count + Times * CycleS1,
            get_max_repetitions(S1, N1, S2, S1CountFinal, S2CountFinal, SeenS1, SeenS2);
        false ->
            {NewS2Count, NewIndex} = match_string(S1, S2, 0, 0),
            get_max_repetitions(S1, N1, S2, S1Count + 1, S2Count + NewS2Count, SeenS1 ++ [S1Count rem length(S1)], SeenS2 ++ [S2Count])
    end.

match_string(S1, S2, S1Index, S2Index) when S2Index == length(S2) ->
    {1, S1Index};
match_string(S1, S2, S1Index, S2Index) when S1Index == length(S1) ->
    {0, S1Index};
match_string(S1, S2, S1Index, S2Index) ->
    S1Char = lists:nth(S1Index + 1, S1),
    S2Char = lists:nth(S2Index + 1, S2),
    if
        S1Char == S2Char ->
            match_string(S1, S2, S1Index + 1 rem length(S1), S2Index + 1);
        true ->
            match_string(S1, S2, S1Index + 1 rem length(S1), S2Index)
    end.