-module(slide_puzzle).
-export([sliding_puzzle/1]).

sliding_puzzle(Board) ->
    Goal = [[1,2,3],[4,5,0]],
    Start = Board,
    BFS(Start, Goal, 0, dict:new()).

BFS(State, Goal, Steps, Visited) ->
    case State of
        Goal -> Steps;
        _ ->
            NextStates = generate_next_states(State),
            lists:foldl(fun(State1, Acc) ->
                            Key = state_to_key(State1),
                            case dict:is_key(Key, Visited) of
                                true -> Acc;
                                false ->
                                    NewVisited = dict:store(Key, true, Visited),
                                    BFS(State1, Goal, Steps + 1, NewVisited)
                            end
                        end, -1, NextStates)
end.

generate_next_states(State) ->
    Pos = find_zero(State),
    {Row, Col} = Pos,
    Neighbors = neighbors(Row, Col),
    lists:map(fun({NR, NC}) -> swap(State, Pos, {NR, NC}) end, Neighbors).

find_zero([[0|_]|_]) -> {0, 0};
find_zero([[_|T]|R]) -> case find_zero(R) of
                           {_, _} = P -> P;
                           _ -> find_zero(T)
                       end;
find_zero([H|_]) -> find_zero(H).

neighbors(Row, Col) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filter(fun({DR, DC}) ->
                     NR = Row + DR,
                     NC = Col + DC,
                     NR >= 0 andalso NR < 2 andalso NC >= 0 andalso NC < 3
                 end, Directions).

swap(State, {R1, C1}, {R2, C2}) ->
    List = lists:flatten(State),
    Index1 = R1 * 3 + C1,
    Index2 = R2 * 3 + C2,
    [A, B | _] = lists:split(Index2, List),
    [C | D] = lists:split(Index1, A),
    E = lists:append(C, [B | D]),
    F = lists:append(E, B),
    G = lists:append(F, [A]),
    lists:split(3, G).

state_to_key(State) ->
    lists:flatten(State).