-module(solution).
-export([number_of_beautiful_integers/2]).

number_of_beautiful_integers(Low, High) ->
    count_beautiful(High) - count_beautiful(Low - 1).

count_beautiful(N) when N < 0 -> 0;
count_beautiful(N) ->
    S = integer_to_list(N),
    len = length(S),
    DP = array:new(len + 1, {default, 0}),
    DP1 = array:set(0, {0, 0, 0, true}, DP),
    helper(S, 0, 0, 0, true, true, DP1).

helper([], _, _, _, _, _, _) -> 0;
helper(S, Pos, cnt, diff, tight, lead, DP) ->
    if
        Pos == length(S) ->
            case (cnt rem 2 == 0) and (diff == 0) of
                true -> 1;
                false -> 0
            end;
        true ->
            Key = {Pos, cnt, diff, tight, lead},
            case array:get(Key, DP) of
                undefined ->
                    MaxDigit = if tight -> list_to_integer([lists:nth(Pos + 1, S)]) ; true -> 9 end,
                    Total = 0,
                    I = 0,
                    loop(I, MaxDigit, S, Pos, cnt, diff, tight, lead, DP, Total);
                Val -> Val
            end
    end.

loop(I, MaxDigit, S, Pos, cnt, diff, tight, lead, DP, Total) when I > MaxDigit ->
    array:set({Pos, cnt, diff, tight, lead}, Total, DP),
    Total;
loop(I, MaxDigit, S, Pos, cnt, diff, tight, lead, DP, Total) ->
    NewTight = tight and (I == MaxDigit),
    NewLead = lead and (I == 0),
    NewDiff = if
        NewLead -> 0;
        true -> diff + (if I > 0 -> 1; true -> -1 end)
    end,
    NewCnt = if
        NewLead -> cnt;
        true -> cnt + 1
    end,
    NextTotal = helper(S, Pos + 1, NewCnt, NewDiff, NewTight, NewLead, DP),
    loop(I + 1, MaxDigit, S, Pos, cnt, diff, tight, lead, DP, Total + NextTotal).