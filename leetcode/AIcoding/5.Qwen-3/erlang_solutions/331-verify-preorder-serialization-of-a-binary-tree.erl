-module(solution).
-export([is_valid_serialization/1]).

is_valid_serialization(S) ->
    lists:all(fun(X) -> X =/= undefined end, lists:reverse(lists:foldl(fun(E, Acc) ->
        case Acc of
            [H | T] when H > 0 ->
                [H - 1 | T];
            [H | T] when H == 0 ->
                [H - 1 | T];
            _ ->
                [H - 1 | T]
        end
    end, [1], binary_to_list(S)))).