-module(solution).
-export([is_possible/2]).

is_possible(Players, Rounds) ->
    PlayersNum = length(Players),
    case PlayersNum of
        1 -> true;
        _ ->
            Max = lists:max(Players),
            Min = lists:min(Players),
            if
                Max - Min > Rounds -> false;
                true -> true
            end
    end.