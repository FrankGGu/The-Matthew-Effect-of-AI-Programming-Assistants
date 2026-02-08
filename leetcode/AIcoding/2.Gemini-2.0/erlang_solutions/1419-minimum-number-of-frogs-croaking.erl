-module(min_frogs).
-export([min_number_of_frogs/1]).

min_number_of_frogs(CroakOfFrogs) ->
    min_number_of_frogs(CroakOfFrogs, 0, 0, 0, 0, 0, 0).

min_number_of_frogs([], Frogs, MaxFrogs, _, _, _, _) ->
    if Frogs == 0 ->
        MaxFrogs
    else
        -1
    end;
min_number_of_frogs([H|T], Frogs, MaxFrogs, C, R, O, A) ->
    case H of
        $c ->
            min_number_of_frogs(T, Frogs + 1, max(MaxFrogs, Frogs + 1), C + 1, R, O, A);
        $r ->
            if C > 0 ->
                min_number_of_frogs(T, Frogs, MaxFrogs, C - 1, R + 1, O, A)
            else
                -1
            end;
        $o ->
            if R > 0 ->
                min_number_of_frogs(T, Frogs, MaxFrogs, C, R - 1, O + 1, A)
            else
                -1
            end;
        $a ->
            if O > 0 ->
                min_number_of_frogs(T, Frogs, MaxFrogs, C, R, O - 1, A + 1)
            else
                -1
            end;
        $k ->
            if A > 0 ->
                min_number_of_frogs(T, Frogs - 1, MaxFrogs, C, R, O, A - 1)
            else
                -1
            end
    end.