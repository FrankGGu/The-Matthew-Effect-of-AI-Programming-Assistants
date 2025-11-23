-module(solution).
-export([maximum_width_of_vertical_bars/1]).

maximum_width_of_vertical_bars(Grid) ->
    Columns = lists:foldl(fun(Row, Acc) -> 
        lists:zipwith(fun(A, B) -> A ++ [B] end, Acc, Row) 
    end, lists:seq(0, length(hd(Grid)) - 1), Grid),
    lists:map(fun(Column) -> length(lists:usort(Column)) end, Columns).

lists:seq(Start, End) when Start > End -> [];
lists:seq(Start, End) -> [Start | lists:seq(Start + 1, End)].

lists:zipwith(Fun, List1, List2) ->
    lists:reverse(zipwith(Fun, List1, List2, [])).

zipwith(_, [], [], Acc) -> Acc;
zipwith(Fun, [H1 | T1], [H2 | T2], Acc) ->
    zipwith(Fun, T1, T2, [Fun(H1, H2) | Acc]).

lists:usort(List) ->
    lists:usort(List, []).

lists:usort([], Acc) -> Acc;
lists:usort([H | T], Acc) ->
    case lists:member(H, Acc) of
        true -> lists:usort(T, Acc);
        false -> lists:usort(T, [H | Acc])
    end.