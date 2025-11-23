-module(solution).
-export([is_array_special/1]).

is_array_special(Nums) ->
    case Nums of
        [] -> true;
        [_] -> true;
        _ ->
            check_pairs(Nums)
    end.

check_pairs([X, Y | Rest]) ->
    case (X rem 2) =:= (Y rem 2) of
        true -> false;
        false -> check_pairs([Y | Rest])
    end;
check_pairs(_) -> true.