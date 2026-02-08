-module(solution).
-export([find_original_string/1]).

find_original_string(S) ->
    Stack = [],
    Result = lists:foldl(fun(Char, Acc) ->
        case Char of
            $# -> case Acc of
                        [] -> [];
                        [_ | Rest] -> Rest
                    end;
            _ -> [Char | Acc]
        end
    end, Stack, lists:reverse(S)),
    lists:reverse(Result).