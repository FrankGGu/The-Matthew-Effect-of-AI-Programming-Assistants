-module(atoi).
-export([my_atoi/1]).

my_atoi(Str) ->
    my_atoi(Str, 0, 1, false).

my_atoi([], _, _, _) ->
    0;
my_atoi([H | T], Val, Sign, IsNum) ->
    case H of
        $' ' when not IsNum ->
            my_atoi(T, Val, Sign, IsNum);
        $+ when not IsNum ->
            my_atoi(T, Val, 1, true);
        $- when not IsNum ->
            my_atoi(T, Val, -1, true);
        D when D >= $0, D =< $9 ->
            NewVal = Val * 10 + (D - $0),
            if
                NewVal > 2147483647 ->
                    2147483647;
                NewVal < -2147483648 ->
                    -2147483648;
                true ->
                    my_atoi(T, NewVal, Sign, true)
            end;
        _ ->
            if
                IsNum ->
                    Val * Sign;
                true ->
                    0
            end
    end.