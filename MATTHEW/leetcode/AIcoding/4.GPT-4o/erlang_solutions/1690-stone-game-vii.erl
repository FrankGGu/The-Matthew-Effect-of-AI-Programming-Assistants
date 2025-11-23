-module(solution).
-export([stone_game_vii/1]).

stone_game_vii(Stones) ->
    stone_game_vii_helper(Stones, 0, length(Stones)).

stone_game_vii_helper(Stones, Score1, Score2) when Score2 - Score1 > 1 ->
    NewStones1 = tl(Stones),
    NewStones2 = lists:sublist(Stones, Score2 - Score1 - 1),
    max(stone_game_vii_helper(NewStones1, Score1 + hd(Stones), Score2),
        stone_game_vii_helper(NewStones2, Score1 + hd(lists:last(Stones)), Score2 - 1));
stone_game_vii_helper(Stones, Score1, Score2) ->
    Score1.