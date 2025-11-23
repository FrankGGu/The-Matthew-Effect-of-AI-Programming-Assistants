-module(stone_game_iii).
-export([stone_game_iii/1]).

stone_game_iii(StoneValue) ->
    N = length(StoneValue),
    Memo = dict:new(),
    score_diff(StoneValue, 0, Memo) ->
        "Alice",
    score_diff(StoneValue, 0, Memo) < 0 ->
        "Bob",
    "Tie".

score_diff(StoneValue, Index, Memo) ->
    case dict:find(Index, Memo) of
        {ok, Val} ->
            Val;
        error ->
            N = length(StoneValue),
            if Index >= N ->
                0;
            true ->
                Score1 = StoneValue[Index+1] - score_diff(StoneValue, Index + 1, Memo),
                Score2 = if Index + 1 < N then
                             lists:sum(lists:sublist(StoneValue, Index + 1, 2)) - score_diff(StoneValue, Index + 2, Memo)
                         else
                             -100000000000
                         end,
                Score3 = if Index + 2 < N then
                             lists:sum(lists:sublist(StoneValue, Index + 1, 3)) - score_diff(StoneValue, Index + 3, Memo)
                         else
                             -100000000000
                         end,
                MaxScore = lists:max([Score1, Score2, Score3]),
                dict:store(Index, MaxScore, Memo),
                MaxScore
            end
    end.