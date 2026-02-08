-module(solution).
-export([is_transformable/2]).

is_transformable(S, T) ->
    case string:to_list(S) -- string:to_list(T) of
        [] -> true;
        _ -> false
    end.