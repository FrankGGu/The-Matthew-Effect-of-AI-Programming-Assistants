-module(solution).
-export([ship_within_days/2]).

ship_within_days(Packages, D) ->
    Left = lists:max(Packages),
    Right = lists:sum(Packages),
    binary_search(Packages, D, Left, Right).

binary_search(Packages, D, Left, Right) when Left < Right ->
    Mid = (Left + Right) div 2,
    case can_ship(Packages, Mid, D) of
        true -> binary_search(Packages, D, Left, Mid);
        false -> binary_search(Packages, D, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) -> Left.

can_ship([], _, 0) -> true;
can_ship([], _, _) -> false;
can_ship([H | T], Capacity, Days) ->
    if H > Capacity -> false;
       true ->
            case can_ship(T, Capacity - H, Days) of
                true -> true;
                false -> can_ship(T, Capacity, Days - 1)
            end
    end.