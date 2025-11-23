-module(solution).
-export([stoneGameVI/2]).

stoneGameVI(AliceValues, BobValues) ->
    Combined = lists:zip(AliceValues, BobValues),

    Sorted = lists:sort(fun({A1, B1}, {A2, B2}) ->
                            (A1 + B1) > (A2 + B2)
                        end, Combined),

    calculate_scores(Sorted, 0, 0, 0).

calculate_scores([], _Turn, AliceScore, BobScore) ->
    AliceScore - BobScore;
calculate_scores([{A, B} | Rest], Turn, AliceScore, BobScore) ->
    if
        Turn rem 2 == 0 ->
            calculate_scores(Rest, Turn + 1, AliceScore + A, BobScore);
        true ->
            calculate_scores(Rest, Turn + 1, AliceScore, BobScore + B)
    end.