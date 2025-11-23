-module(longest_mountain_in_array).
-export([longest_mountain/1]).

longest_mountain(Arr) ->
    N = length(Arr),
    Max = 0,
    Up = lists:seq(1, N-1),
    Down = lists:seq(1, N-1),
    UpValues = up_values(Arr, Up, 1, []),
    DownValues = down_values(Arr, Down, 1, []),
    find_max(UpValues, DownValues, 0).

up_values(_, [], _, Acc) -> Acc;
up_values(Arr, [I|Is], Index, Acc) ->
    case Arr!!Index > Arr!!(Index-1) of
        true -> up_values(Arr, Is, Index+1, [Acc ++ [1]] ++ [Index]);
        false -> up_values(Arr, Is, Index+1, [Acc ++ [0]] ++ [Index])
    end.

down_values(_, [], _, Acc) -> Acc;
down_values(Arr, [I|Is], Index, Acc) ->
    case Arr!!Index < Arr!!(Index-1) of
        true -> down_values(Arr, Is, Index+1, [Acc ++ [1]] ++ [Index]);
        false -> down_values(Arr, Is, Index+1, [Acc ++ [0]] ++ [Index])
    end.

find_max([], [], Max) -> Max;
find_max([U|Us], [D|Ds], Max) ->
    if U == 1 andalso D == 1 -> find_max(Us, Ds, max(Max, 2));
       true -> find_max(Us, Ds, Max)
    end.