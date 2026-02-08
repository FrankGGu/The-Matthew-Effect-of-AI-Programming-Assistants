-module(min_swaps).
-export([min_swaps/1]).

min_swaps(Grid) ->
    Rows = lists:reverse(Grid),
    N = length(Rows),
    Count = lists:seq(0, N-1),
    min_swaps(Rows, Count, 0).

min_swaps([], _, _) -> 0;
min_swaps([Row | Rest], Count, Index) ->
    Case = case find_case(Row, Index) of
               -1 -> -1;
               C -> C
           end,
    if
        Case == -1 -> -1;
        true ->
            NewCount = lists:delete(Case, Count),
            Swaps = Case - Index,
            Swaps + min_swaps(Rest, NewCount, Index + 1)
    end.

find_case(_, _) -> -1;
find_case(Row, Index) ->
    find_case(Row, Index, 0).

find_case([], _, _) -> -1;
find_case([H | T], Index, Pos) ->
    case H of
        1 -> 
            if Pos >= Index -> Pos;
               true -> find_case(T, Index, Pos + 1)
            end;
        _ -> find_case(T, Index, Pos + 1)
    end.