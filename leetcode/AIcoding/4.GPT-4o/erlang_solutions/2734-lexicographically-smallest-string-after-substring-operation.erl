-module(solution).
-export([smallest_string_after_substring_operation/2]).

smallest_string_after_substring_operation(S, P) ->
    smallest_string(S, lists:seq(1, length(S)), P).

smallest_string(S, Indices, P) ->
    lists:foldl(fun(I, Acc) ->
        case lists:nth(I, P) of
            false -> Acc;
            true -> lists:sublist(Acc, 1, I - 1) ++ [lists:min(Acc)] ++ lists:sublist(Acc, I + 1, length(Acc) - I)
        end
    end, list_to_tuple(S), Indices).

list_to_tuple(List) ->
    lists:map(fun(X) -> X end, List).

lists:min(List) ->
    lists:foldl(fun(X, Acc) -> min(X, Acc) end, hd(List), tl(List)).