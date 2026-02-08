-module(solution).
-export([open_lock/2]).

open_lock(Deadends, Target) ->
    DeadendsSet = sets:from_list(Deadends),
    bfs([{<<"0000">>, 0}], DeadendsSet, Target).

bfs([], _, _) -> -1;
bfs([{Current, Steps} | Rest], DeadendsSet, Target) ->
    case Current of
        Target -> Steps;
        _ when sets:is_element(Current, DeadendsSet) -> bfs(Rest, DeadendsSet, Target);
        _ -> 
            NextStates = generate_next_states(Current),
            bfs(Rest ++ lists:filter(fun(State) -> not sets:is_element(State, DeadendsSet) end, NextStates), DeadendsSet, Target)
    end.

generate_next_states(Current) ->
    lists:flatmap(fun(Index) -> 
        [increment(Current, Index), decrement(Current, Index)]
    end, lists:seq(1, 4)).

increment(Current, Index) ->
    NewDigit = (list_to_integer(string:substr(Current, Index, 1)) + 1) rem 10,
    string:substr(Current, 1, Index - 1) ++ integer_to_list(NewDigit) ++ string:substr(Current, Index + 1).

decrement(Current, Index) ->
    NewDigit = (list_to_integer(string:substr(Current, Index, 1)) + 9) rem 10,
    string:substr(Current, 1, Index - 1) ++ integer_to_list(NewDigit) ++ string:substr(Current, Index + 1).