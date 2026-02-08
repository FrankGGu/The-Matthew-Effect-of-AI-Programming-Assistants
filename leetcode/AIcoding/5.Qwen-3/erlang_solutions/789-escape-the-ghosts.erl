-module(escape_the_ghosts).
-export([escape_ghosts/1]).

escape_ghosts(Ghosts) ->
    Player = {0, 0},
    Target = hd(lists:reverse(Player)),
    PlayerDist = abs(element(1, Player)) + abs(element(2, Player)),
    GhostDist = lists:min([abs(GhostX) + abs(GhostY) || {GhostX, GhostY} <- Ghosts]),
    PlayerDist < GhostDist.