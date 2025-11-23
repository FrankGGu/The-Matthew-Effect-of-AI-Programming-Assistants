-module(solution).
-export([valid_mountain_array/1]).

valid_mountain_array(Arr) ->
    Len = length(Arr),
    if
        Len < 3 -> false;
        true ->
            I = 1,
            Len1 = Len - 1,
            Up = up(Arr, I, Len1),
            Down = down(Arr, Up, Len1),
            Down == Len1
    end.

up(_, I, Len1) when I > Len1 -> I - 1;
up(Arr, I, Len1) ->
    case Arr!!I > Arr!!(I-1) of
        true -> up(Arr, I + 1, Len1);
        false -> I - 1
    end.

down(_, I, Len1) when I > Len1 -> I - 1;
down(Arr, I, Len1) ->
    case Arr!!I < Arr!!(I-1) of
        true -> down(Arr, I + 1, Len1);
        false -> I - 1
    end.