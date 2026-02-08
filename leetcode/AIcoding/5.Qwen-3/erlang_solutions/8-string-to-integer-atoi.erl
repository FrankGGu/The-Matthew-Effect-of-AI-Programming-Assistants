-module(atoi).
-export([my_atoi/1]).

my_atoi(Str) ->
    my_atoi(Str, 0, 1, false).

my_atoi([], _Pos, _Sign, _Started) ->
    0;
my_atoi([H|T], Pos, Sign, Started) ->
    case H of
        $ -> 
            if not Started -> my_atoi(T, Pos + 1, Sign, Started);
               true -> 0
            end;
        $+ -> 
            if not Started -> my_atoi(T, Pos + 1, 1, true);
               true -> 0
            end;
        $- -> 
            if not Started -> my_atoi(T, Pos + 1, -1, true);
               true -> 0
            end;
        D when D >= $0, D =< $9 ->
            my_atoi(T, Pos + 1, Sign, true, D - $0);
        _ ->
            if Started -> 0;
               true -> 0
            end
    end.

my_atoi([], _Pos, _Sign, _Started, _Num) ->
    0;
my_atoi([H|T], Pos, Sign, Started, Num) ->
    case H of
        D when D >= $0, D =< $9 ->
            NewNum = Num * 10 + (D - $0),
            if NewNum < 0 -> 0;
               true -> my_atoi(T, Pos + 1, Sign, true, NewNum)
            end;
        _ ->
            if Started -> Sign * Num;
               true -> 0
            end
    end.