-module(solution).
-export([min_deletion_size/1]).

-spec min_deletion_size(A :: [string()]) -> integer().
min_deletion_size(A) ->
    case A of
        [] -> 0;
        [[]|_] -> 0;
        _ ->
            Columns = transpose(A),
            lists:foldl(fun(Col, Acc) ->
                                case is_column_sorted(Col) of
                                    true -> Acc;
                                    false -> Acc + 1
                                end
                        end, 0, Columns)
    end.

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose(Matrix) ->
    [ [H || [H|_] <- Matrix] | transpose([T || [_|T] <- Matrix]) ].

is_column_sorted([]) -> true;
is_column_sorted([_]) -> true;
is_column_sorted([H1, H2 | T]) ->
    if
        H1 > H2 -> false;
        true -> is_column_sorted([H2 | T])
    end.