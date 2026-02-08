-module(solution).
-export([split_string/1]).

split_string(S) ->
    split_string(S, []).

split_string([], Acc) ->
    case check_descending(Acc) of
        true -> true;
        false -> false
    end;
split_string(S) ->
    lists:foldl(fun(X, Acc) -> 
        case Acc of
            [] -> [[X]];
            [H | T] -> 
                case H of
                    [Last | _] when Last - 1 =:= X -> [[X] | Acc];
                    _ -> [[X] | Acc]
                end
        end
    end, [], string:to_integer(S)).

check_descending([]) -> true;
check_descending([_]) -> true;
check_descending([H1, H2 | T]) -> 
    if H1 - 1 =:= H2 -> check_descending([H2 | T]);
    true -> false
    end.