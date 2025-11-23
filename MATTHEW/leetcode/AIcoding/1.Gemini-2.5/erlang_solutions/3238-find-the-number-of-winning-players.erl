-module(solution).
-export([findWinningPlayers/1]).

findWinningPlayers(Skills) ->
    N = length(Skills),
    case N of
        0 -> 0;
        1 -> 1;
        _ ->
            WinningFlags = [ is_player_winning(PlayerI, Skills) || PlayerI <- Skills ],
            lists:foldl(fun(Bool, Acc) ->
                            case Bool of
                                true -> Acc + 1;
                                false -> Acc
                            end
                        end, 0, WinningFlags)
    end.

is_player_winning(PlayerI, AllSkills) ->
    [AttackI, DefenseI] = PlayerI,
    lists:all(fun(PlayerJ) ->
                PlayerI == PlayerJ orelse (
                    [AttackJ, DefenseJ] = PlayerJ,
                    AttackI > AttackJ andalso DefenseI > DefenseJ
                )
            end, AllSkills).