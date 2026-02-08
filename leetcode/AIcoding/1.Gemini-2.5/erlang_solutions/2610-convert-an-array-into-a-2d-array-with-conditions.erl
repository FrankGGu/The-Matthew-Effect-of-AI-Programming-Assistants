-module(solution).
-export([findMatrix/1]).

findMatrix(Nums) ->
    lists:foldl(fun(Num, AccRows) -> add_to_rows(Num, AccRows) end, [], Nums).

add_to_rows(Num, AccRows) ->
    add_to_rows_recursive(Num, AccRows, []).

add_to_rows_recursive(Num, [], AccBeforeFoundRow) ->
    lists:reverse([[Num] | AccBeforeFoundRow]);
add_to_rows_recursive(Num, [H|T], AccBeforeFoundRow) ->
    case lists:member(Num, H) of
        true ->
            add_to_rows_recursive(Num, T, [H|AccBeforeFoundRow]);
        false ->
            lists:reverse(AccBeforeFoundRow) ++ [[Num|H]|T]
    end.