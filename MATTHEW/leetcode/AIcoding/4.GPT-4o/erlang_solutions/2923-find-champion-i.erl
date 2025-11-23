-module(solution).
-export([find_champion/1]).

find_champion(teams) ->
    case lists:foldl(fun({Team1, Team2}, Acc) ->
                        case Acc of
                            none -> Team1;
                            Champion -> if Team1 =:= Champion -> Champion;
                                         Team2 =:= Champion -> Champion;
                                         true -> none
                                     end
                        end
                     end, none, teams) of
        none -> undefined;
        Champion -> Champion
    end.