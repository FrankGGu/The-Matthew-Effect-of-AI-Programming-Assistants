-module(solution).
-export([find_winners/1]).

find_winners(Matches) ->
    {LossCounts, AllPlayersSet} = lists:foldl(
        fun([Winner, Loser], {AccLossCounts, AccAllPlayersSet}) ->
            NewAccLossCounts = maps:update_with(Loser, fun(Count) -> Count + 1 end, 1, AccLossCounts),
            NewAccAllPlayersSet = sets:add_element(Winner, sets:add_element(Loser, AccAllPlayersSet)),
            {NewAccLossCounts, NewAccAllPlayersSet}
        end,
        {#{}, sets:new()},
        Matches
    ),

    AllPlayersList = sets:to_list(AllPlayersSet),

    {ZeroLosses, OneLoss} = lists:foldl(
        fun(Player, {AccZeroLosses, AccOneLoss}) ->
            LossCount = maps:get(Player, LossCounts, 0),
            case LossCount of
                0 -> {[Player | AccZeroLosses], AccOneLoss};
                1 -> {AccZeroLosses, [Player | AccOneLoss]};
                _ -> {AccZeroLosses, AccOneLoss}
            end
        end,
        {[], []},
        AllPlayersList
    ),

    [lists:sort(ZeroLosses), lists:sort(OneLoss)].