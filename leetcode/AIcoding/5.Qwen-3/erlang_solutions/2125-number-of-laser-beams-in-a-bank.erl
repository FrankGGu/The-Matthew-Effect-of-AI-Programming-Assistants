-module(laser_beams).
-export([number_of_laser_beams/1]).

number_of_laser_beams(Bank) ->
    Count = lists:foldl(fun(Row, Acc) ->
        case lists:foldl(fun(Ch, C) -> if Ch == $1 -> C + 1; true -> C end end, 0, Row) of
            0 -> Acc;
            N -> Acc + (Acc * N)
        end
    end, 0, Bank).