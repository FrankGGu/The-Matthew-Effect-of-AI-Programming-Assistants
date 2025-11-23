-module(solution).
-export([min_remove_to_make_valid/1]).

min_remove_to_make_valid(S) ->
    ValidIndices = get_valid_indices(S),
    lists:filter(fun(Index) -> Index >= 0 end, ValidIndices).

get_valid_indices(S) ->
    lists:foldl(fun(Char, {Stack, Indices}) ->
        case Char of
            $'(' -> { [length(Indices)] ++ Stack, Indices };
            $')' -> case Stack of
                        [] -> { Stack, [-1 | Indices] };
                        [_ | Rest] -> { Rest, Indices ++ [length(Indices)] }
                    end;
            _ -> { Stack, Indices ++ [length(Indices)] }
        end
    end, {[], []}, list_to_binary(S)),
    lists:filter(fun(Index) -> Index >= 0 end, lists:zipwith(fun(I, J) -> I end, lists:seq(1, length(S)), lists:reverse(Indices))).