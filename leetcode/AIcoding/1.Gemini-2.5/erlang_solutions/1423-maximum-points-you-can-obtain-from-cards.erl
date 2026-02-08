-module(solution).
-export([max_score/2]).

-spec max_score(CardPoints :: [integer()], K :: integer()) -> integer().
max_score(CardPoints, K) ->
    N = length(CardPoints),
    CardPointsArray = array:from_list(CardPoints),

    InitialLeftSum = calculate_sum_range(CardPointsArray, 0, K - 1),
    MaxScore = InitialLeftSum,

    find_max_score_loop(CardPointsArray, N, K, 1, InitialLeftSum, 0, MaxScore).

calculate_sum_range(Array, StartIndex, EndIndex) ->
    if
        StartIndex > EndIndex -> 0;
        true ->
            lists:foldl(fun(Idx, Acc) -> Acc + array:get(Idx, Array) end, 0, lists:seq(StartIndex, EndIndex))
    end.

find_max_score_loop(CardPointsArray, N, K, I, CurrentLeftSum, CurrentRightSum, MaxScore) ->
    if
        I > K ->
            MaxScore;
        true ->
            RemovedLeftCard = array:get(K - I, CardPointsArray),
            AddedRightCard = array:get(N - I, CardPointsArray),

            NewCurrentLeftSum = CurrentLeftSum - RemovedLeftCard,
            NewCurrentRightSum = CurrentRightSum + AddedRightCard,
            CurrentTotalScore = NewCurrentLeftSum + NewCurrentRightSum,

            NewMaxScore = max(MaxScore, CurrentTotalScore),

            find_max_score_loop(CardPointsArray, N, K, I + 1, NewCurrentLeftSum, NewCurrentRightSum, NewMaxScore)
    end.