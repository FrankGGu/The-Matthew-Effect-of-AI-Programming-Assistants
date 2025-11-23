-module(stone_game_v).
-export([stone_game_v/1]).

stone_game_v(StoneValue) ->
    N = length(StoneValue),
    Memo = dict:new(),
    stone_game_v(StoneValue, 1, N, Memo).

stone_game_v(StoneValue, Left, Right, Memo) ->
    if Left >= Right then
        0
    else
        case dict:find({Left, Right}, Memo) of
            {ok, Value} ->
                Value;
            error ->
                Result = calculate_max_score(StoneValue, Left, Right, Memo),
                dict:store({Left, Right}, Result, Memo),
                Result
        end
    end.

calculate_max_score(StoneValue, Left, Right, Memo) ->
    Sum = lists:sum(lists:sublist(StoneValue, Left, Right - Left + 1)),
    MaxScore = calculate_max_score_helper(StoneValue, Left, Right, Sum, Memo),
    MaxScore.

calculate_max_score_helper(StoneValue, Left, Right, Sum, Memo) ->
    MaxScore = 0,
    LeftSum = 0,
    for(I = Left, I =< Right - 1, I = I + 1) do
        LeftSum = LeftSum + lists:nth(I, StoneValue),
        RightSum = Sum - LeftSum,

        if LeftSum < RightSum then
            Score = LeftSum + stone_game_v(StoneValue, I + 1, Right, Memo)
        elseif LeftSum > RightSum then
            Score = RightSum + stone_game_v(StoneValue, Left, I, Memo)
        else
            Score1 = LeftSum + stone_game_v(StoneValue, I + 1, Right, Memo),
            Score2 = RightSum + stone_game_v(StoneValue, Left, I, Memo),
            Score = max(Score1, Score2)
        end,
        MaxScore = max(MaxScore, Score)
    end,
    MaxScore.

for(Start, End, Step, Fun) ->
    for(Start, End, Step, Fun, []).

for(Start, End, Step, Fun, Acc) ->
    if Start > End then
        lists:reverse(Acc)
    else
        for(Start + Step, End, Step, Fun, [Fun(Start) | Acc])
    end.