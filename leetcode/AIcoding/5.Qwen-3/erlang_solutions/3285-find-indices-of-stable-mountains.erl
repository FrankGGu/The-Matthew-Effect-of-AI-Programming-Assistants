-module(solution).
-export([find_indices/1]).

find_indices(Mountains) ->
    find_indices(Mountains, 0, []).

find_indices([], _, Acc) ->
    lists:reverse(Acc);
find_indices([H | T], Index, Acc) ->
    case is_stable(H, T) of
        true -> find_indices(T, Index + 1, [Index | Acc]);
        false -> find_indices(T, Index + 1, Acc)
    end.

is_stable([], _) ->
    true;
is_stable([A | B], Rest) ->
    case Rest of
        [] -> true;
        _ ->
            case B of
                [] -> true;
                _ ->
                    A >= hd(Rest) andalso A >= hd(B)
            end
    end.