-module(solution).
-export([sort_array_by_parity_ii/1]).

sort_array_by_parity_ii(A) ->
    sort_array_by_parity_ii(A, [], []).

sort_array_by_parity_ii([], Even, Odd) ->
    lists:zipwith(fun(E, O) -> [E, O] end, Even, Odd);
sort_array_by_parity_ii([H|T], Even, Odd) ->
    case H rem 2 of
        0 ->
            sort_array_by_parity_ii(T, Even ++ [H], Odd);
        1 ->
            sort_array_by_parity_ii(T, Even, Odd ++ [H])
    end.