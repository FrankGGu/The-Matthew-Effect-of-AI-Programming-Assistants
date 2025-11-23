-module(maximum_value_after_insertion).
-export([maximum_value/2]).

maximum_value(N, X) ->
    case string:to_integer(X) of
        {error, _} -> {error, bad_argument};
        X_int ->
            N_str = integer_to_list(N),
            Inserted = lists:foldl(fun (C, Acc) ->
                case Acc of
                    [] -> [C];
                    [H | _] when H < C -> [C | Acc];
                    _ -> [H | Acc]
                end
            end, [], N_str),
            case Inserted of
                [H | T] -> lists:reverse([H | T]) ++ lists:reverse([X]);
                _ -> lists:reverse(Inserted) ++ [X]
            end
    end.