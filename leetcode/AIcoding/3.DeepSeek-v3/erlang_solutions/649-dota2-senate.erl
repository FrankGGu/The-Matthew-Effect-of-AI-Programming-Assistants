-module(solution).
-export([predictPartyVictory/1]).

predictPartyVictory(Senate) ->
    Queue = lists:map(fun
        ($R) -> {r, 0};
        ($D) -> {d, 0}
    end, Senate),
    {RCount, DCount} = count(Queue, 0, 0),
    battle(Queue, RCount, DCount).

count([], R, D) -> {R, D};
count([{r, _}|Rest], R, D) -> count(Rest, R + 1, D);
count([{d, _}|Rest], R, D) -> count(Rest, R, D + 1).

battle(Queue, 0, _) -> "Dire";
battle(Queue, _, 0) -> "Radiant";
battle([{Party, Banned}|Rest], RCount, DCount) ->
    case Party of
        r when Banned > 0 ->
            battle(Rest, RCount - 1, DCount);
        d when Banned > 0 ->
            battle(Rest, RCount, DCount - 1);
        r ->
            NewQueue = Rest ++ [{r, 0}],
            battle(ban(NewQueue, $D), RCount, DCount - 1);
        d ->
            NewQueue = Rest ++ [{d, 0}],
            battle(ban(NewQueue, $R), RCount - 1, DCount)
    end.

ban([], _) -> [];
ban([{Party, Banned}|Rest], ToBan) ->
    case Party of
        ToBan when Banned == 0 -> [{Party, 1}|Rest];
        _ -> [{Party, Banned}|ban(Rest, ToBan)]
    end.