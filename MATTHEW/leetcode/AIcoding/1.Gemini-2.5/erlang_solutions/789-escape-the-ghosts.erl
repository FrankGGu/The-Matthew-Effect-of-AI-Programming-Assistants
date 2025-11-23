-module(solution).
-export([escapeGhosts/2]).

escapeGhosts(Ghosts, Target) ->
    [TargetX, TargetY] = Target,
    PlayerDist = abs(TargetX) + abs(TargetY),

    lists:all(
        fun([GhostX, GhostY]) ->
            GhostDist = abs(TargetX - GhostX) + abs(TargetY - GhostY),
            PlayerDist < GhostDist
        end,
        Ghosts
    ).

abs(N) when N < 0 -> -N;
abs(N) -> N.