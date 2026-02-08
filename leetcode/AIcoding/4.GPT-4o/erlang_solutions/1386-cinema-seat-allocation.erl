-module(solution).
-export([maxNumberOfFamilies/2]).

maxNumberOfFamilies(N, Rows) ->
    Seats = lists:foldl(fun(Row, Acc) -> 
        case Row of
            Row when Row band 0b11111100 =:= 0b11111100 -> Acc + 2; % row has 1 and 2
            Row when Row band 0b11110000 =:= 0b11110000 -> Acc + 1; % row has 1
            Row when Row band 0b00001111 =:= 0b00001111 -> Acc + 1; % row has 2
            Row when Row band 0b00001100 =:= 0b00001100 -> Acc + 1; % row has 2
            _ -> Acc
        end
    end, 0, Rows),
    N * 2 - Seats.