-module(solution).
-export([min_deletion_size/1]).

min_deletion_size(List) ->
    Columns = lists:transpose(List),
    lists:foldl(fun(Column, Acc) ->
        case is_sorted(Column) of
            true -> Acc;
            false -> Acc + 1
        end
    end, 0, Columns).

is_sorted(List) ->
    case List of
        [] -> true;
        [_] -> true;
        _ -> lists:all(fun({A, B}) -> A =< B end, lists:zip(List, tl(List)))
    end.