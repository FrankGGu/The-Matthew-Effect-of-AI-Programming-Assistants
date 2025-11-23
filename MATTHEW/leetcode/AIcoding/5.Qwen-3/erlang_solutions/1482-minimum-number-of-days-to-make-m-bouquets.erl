-module(m_bouquets).
-export([min_days/2]).

min_days(Flowers, M) ->
    min_days(Flowers, M, 0, length(Flowers) - 1).

min_days(_, _, Left, Right) when Left > Right ->
    -1;
min_days(Flowers, M, Left, Right) ->
    Mid = (Left + Right) div 2,
    if
        is_possible(Flowers, M, Mid) ->
            case min_days(Flowers, M, Left, Mid - 1) of
                -1 -> Mid;
                Val -> min(Val, Mid)
            end;
        true ->
            min_days(Flowers, M, Mid + 1, Right)
    end.

is_possible([], _, _) ->
    true;
is_possible([H | T], M, Days) ->
    if
        H > Days ->
            is_possible(T, M, Days);
        true ->
            count_bouquets([H | T], M, Days, 0, 0)
    end.

count_bouquets([], M, _, Current, Bouquets) ->
    Bouquets >= M;
count_bouquets([H | T], M, Days, Current, Bouquets) ->
    if
        H > Days ->
            count_bouquets(T, M, Days, 0, Bouquets);
        true ->
            NewCurrent = Current + 1,
            if
                NewCurrent == Days + 1 ->
                    count_bouquets(T, M, Days, 0, Bouquets + 1);
                true ->
                    count_bouquets(T, M, Days, NewCurrent, Bouquets)
            end
    end.