-module(solution).
-export([string_transformation/2]).

string_transformation(S, T) ->
    case transform(S, T, []) of
        [] -> false;
        _ -> true
    end.

transform(S, T, Visited) when S =:= T -> [S];
transform(S, T, Visited) ->
    case lists:member(S, Visited) of
        true -> [];
        false ->
            NewVisited = [S | Visited],
            lists:flatmap(fun(X) -> transform(X, T, NewVisited) end, next_states(S)).

next_states(S) ->
    lists:filtermap(fun(C) ->
        case string:to_integer(C) of
            {error, _} -> [];
            {ok, _} -> [string:to_list(C)]
        end
    end, all_possible_changes(S)).

all_possible_changes(S) ->
    lists:map(fun(I) -> lists:replace_element(I, S, ?CHARS) end, lists:seq(1, length(S))).

replace_element(Index, List, NewChar) ->
    lists:take(Index - 1, List) ++ [NewChar] ++ lists:drop(Index, List).