-spec escape_ghosts(:: [[integer()]], :: [integer()]) -> boolean().
escape_ghosts(Ghosts, Target) ->
    [Tx, Ty] = Target,
    PlayerDist = abs(Tx) + abs(Ty),
    lists:all(fun([Gx, Gy]) -> 
        GhostDist = abs(Gx - Tx) + abs(Gy - Ty),
        PlayerDist < GhostDist
    end, Ghosts).