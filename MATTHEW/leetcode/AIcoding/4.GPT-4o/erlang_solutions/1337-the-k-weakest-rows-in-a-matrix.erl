-module(solution).
-export([k_weakest_rows/2]).

k_weakest_rows(Matrix, K) ->
    RowsWithStrength = lists:map(fun(Row) -> {length(lists:filter(fun(X) -> X == 1 end, Row)), Row} end, Matrix),
    SortedRows = lists:sort(fun({Strength1, _}, {Strength2, _}) -> 
                                    case Strength1 == Strength2 of
                                        true -> false;
                                        false -> Strength1 < Strength2 
                                    end 
                               end, RowsWithStrength),
    WeakestRows = lists:map(fun({_, Row}) -> lists:first(Row) end, lists:sublist(SortedRows, K)),
    WeakestRows.