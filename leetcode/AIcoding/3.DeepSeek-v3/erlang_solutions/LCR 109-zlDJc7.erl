-module(solution).
-export([open_lock/2]).

open_lock(Deadends, Target) ->
    DeadSet = sets:from_list(Deadends),
    case sets:is_element("0000", DeadSet) of
        true -> -1;
        false -> bfs(["0000"], DeadSet, Target, 0)
    end.

bfs([], _, _, _) -> -1;
bfs(Queue, DeadSet, Target, Steps) ->
    NewQueue = lists:foldl(fun(Current, Acc) ->
        case Current =:= Target of
            true -> Steps;
            false ->
                NextStates = generate_next_states(Current),
                Filtered = lists:filter(fun(State) ->
                    not sets:is_element(State, DeadSet)
                end, NextStates),
                lists:foreach(fun(State) ->
                    sets:add_element(State, DeadSet)
                end, Filtered),
                Acc ++ Filtered
        end
    end, [], Queue),
    case is_integer(NewQueue) of
        true -> NewQueue;
        false -> bfs(NewQueue, DeadSet, Target, Steps + 1)
    end.

generate_next_states(State) ->
    lists:flatmap(fun(I) ->
        Digit = list_to_integer([lists:nth(I, State)]),
        [lists:sublist(State, I - 1) ++ integer_to_list((Digit + 1) rem 10) ++ lists:nthtail(I, State),
         lists:sublist(State, I - 1) ++ integer_to_list((Digit + 9) rem 10) ++ lists:nthtail(I, State)]
    end, lists:seq(1, 4)).