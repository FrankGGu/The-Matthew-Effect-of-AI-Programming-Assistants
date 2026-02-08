-module(solution).
-export([findChampion/2]).

findChampion(N, Battles) ->
    Defeated = array:new(N, {default, false}),

    UpdatedDefeated = lists:foldl(
        fun([_TeamA, TeamB], AccDefeated) ->
            array:set(TeamB, true, AccDefeated)
        end,
        Defeated,
        Battles
    ),

    Champions = lists:foldl(
        fun(I, AccChampions) ->
            case array:get(I, UpdatedDefeated) of
                false ->
                    [I | AccChampions];
                true ->
                    AccChampions
            end
        end,
        [],
        lists:seq(0, N - 1)
    ),

    case length(Champions) of
        1 ->
            hd(Champions);
        _ ->
            -1
    end.