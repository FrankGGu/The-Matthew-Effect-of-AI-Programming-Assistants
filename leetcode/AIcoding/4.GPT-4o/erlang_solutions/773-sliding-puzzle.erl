-module(sliding_puzzle).
-export([sliding_puzzle/2]).

sliding_puzzle(Start, Target) ->
    StartState = lists:flatten(Start),
    TargetState = lists:flatten(Target),
    bfs([{StartState, 0}], TargetState, dict:new()).

bfs([], _, _) -> -1;
bfs([{State, Steps} | Rest], Target, Visited) ->
    case State of
        _ when State =:= Target -> Steps;
        _ ->
            NewVisited = dict:store(State, true, Visited),
            Neighbors = get_neighbors(State),
            NewStates = [ {NState, Steps + 1} || NState <- Neighbors, not dict:find(NState, NewVisited) ] ++ Rest,
            bfs(NewStates, Target, NewVisited)
    end.

get_neighbors(State) ->
    Index = lists:seq(0, length(State) - 1),
    lists:flatmap(fun(I) ->
        case lists:nth(I + 1, State) of
            0 -> [];
            _ -> swap(State, I, find_zero(State))
        end
    end, Index).

find_zero(State) ->
    lists:find(fun(X) -> X =:= 0 end, State).

swap(State, I, Z) ->
    Temp = lists:replace(State, I, lists:nth(Z + 1, State)),
    lists:replace(Temp, Z, lists:nth(I + 1, State)).