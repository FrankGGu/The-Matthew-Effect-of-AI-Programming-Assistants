-module(solution).
-export([k_similar_strings/2]).

k_similar_strings(Start, Target) ->
    k_similar_strings(Start, Target, [], 0).

k_similar_strings(Start, Target, Visited, Steps) ->
    case Start =:= Target of
        true -> Steps;
        false ->
            case lists:keyfind(Start, 1, Visited) of
                false ->
                    NewVisited = [{Start, Steps} | Visited],
                    NextStates = get_next_states(Start, Target),
                    lists:foldl(fun (Next, Acc) -> k_similar_strings(Next, Target, NewVisited, Steps + 1) end, Acc, NextStates);
                {Start, _} -> 
                    infinity
            end
    end.

get_next_states(Start, Target) ->
    get_next_states(Start, Target, 0, []).

get_next_states(Start, Target, Index, Acc) when Index < length(Start) ->
    case lists:nth(Index + 1, Start) =:= lists:nth(Index + 1, Target) of
        true -> get_next_states(Start, Target, Index + 1, Acc);
        false ->
            lists:foldl(fun (X, Acc) -> 
                case lists:nth(Index + 1, Start) =:= X of
                    true -> Acc;
                    false -> 
                        NewStart = swap(Start, Index, lists:position(X, Start)),
                        [NewStart | Acc]
                end
            end, get_next_states(Start, Target, Index + 1, Acc), lists:sublist(Target, Index + 1))
    end;
get_next_states(_, _, _, Acc) -> 
    lists:reverse(Acc).

swap(List, I, J) ->
    {BeforeI, [Elem | AfterI]} = lists:split(I, List),
    {BeforeJ, [ElemJ | AfterJ]} = lists:split(J - I - 1, AfterI),
    BeforeI ++ [ElemJ] ++ BeforeJ ++ [Elem] ++ AfterJ.