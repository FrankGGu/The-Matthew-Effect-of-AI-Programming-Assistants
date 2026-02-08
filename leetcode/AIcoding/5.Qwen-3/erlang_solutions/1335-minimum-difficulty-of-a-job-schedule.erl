-module(solution).
-export([min_difficulty/2]).

min_difficulty(JobDifficulty, D) ->
    N = length(JobDifficulty),
    if
        D > N -> -1;
        true ->
            DP = array:new(N+1, {0, 0}),
            array:set(0, {0, 0}, DP),
            min_difficulty(JobDifficulty, D, 0, N-1, DP)
    end.

min_difficulty(_, 0, Start, _, _) when Start > 0 -> -1;
min_difficulty(JobDifficulty, 1, Start, End, DP) ->
    Max = lists:max(lists:sublist(JobDifficulty, Start+1, End - Start + 1)),
    array:get(Start, DP) + Max;
min_difficulty(JobDifficulty, D, Start, End, DP) ->
    Min = lists:min(
        [begin
             CurrentMax = lists:max(lists:sublist(JobDifficulty, Start+1, I - Start)),
             Prev = array:get(I, DP),
             if
                 Prev == 0 -> -1;
                 true -> Prev + CurrentMax
             end
         end || I <- lists:seq(Start, End - (D-1)) ]
    ),
    array:set(Start, {Min, D}, DP).

min_difficulty(JobDifficulty, D, Start, End, DP) ->
    case array:get(Start, DP) of
        {Val, _} when Val /= 0 -> Val;
        _ ->
            Res = min_difficulty(JobDifficulty, D, Start, End, DP),
            array:set(Start, {Res, D}, DP)
    end.