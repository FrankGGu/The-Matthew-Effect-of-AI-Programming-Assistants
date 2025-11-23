-module(replace_all_q).
-export([modifyString/1]).

modifyString(S) ->
    modifyString(S, []).

modifyString([], Acc) ->
    lists:reverse(Acc);
modifyString([C | Rest], Acc) when C == ?'? -> 
    case Acc of
        [] ->
            modifyString(Rest, [random_char(0, 25) | Acc]);
        [Prev | _] ->
            Next = random_char(0, 25),
            while_same(Prev, Next),
            modifyString(Rest, [Next | Acc])
    end;
modifyString([C | Rest], Acc) ->
    modifyString(Rest, [C | Acc]).

random_char(Low, High) ->
    Char = rand:uniform(High + 1) + Low,
    Char + $a.

while_same(Prev, Next) ->
    if
        Prev == Next ->
            Next = random_char(0, 25),
            while_same(Prev, Next);
        true ->
            ok
    end.