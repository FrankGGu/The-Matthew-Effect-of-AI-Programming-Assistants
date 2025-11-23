-module(sliding_puzzle).
-export([sliding_puzzle/1]).

sliding_puzzle(Board) ->
    Target = [[1,2,3],[4,5,0]],
    case Board of
        Target -> 0;
        _ ->
            Start = to_tuple(Board),
            Q = queue:in({Start, 0}, queue:new()),
            Visited = sets:add_element(Start, sets:new()),
            bfs(Q, Visited, Target)
    end.

bfs(Q, Visited, Target) ->
    case queue:out(Q) of
        {empty, _} -> -1;
        {{value, {State, Steps}}, Q1} ->
            case to_list(State) of
                Target -> Steps;
                _ ->
                    {I, J} = find_zero(State),
                    Moves = moves(I, J),
                    {NewQ, NewVisited} = lists:foldl(
                        fun({Di, Dj}, {AccQ, AccVisited}) ->
                            NewI = I + Di,
                            NewJ = J + Dj,
                            if
                                NewI >= 0, NewI < 2, NewJ >= 0, NewJ < 3 ->
                                    NewState = swap(State, I, J, NewI, NewJ),
                                    case sets:is_element(NewState, AccVisited) of
                                        false ->
                                            NewQ = queue:in({NewState, Steps + 1}, AccQ),
                                            NewVisited = sets:add_element(NewState, AccVisited),
                                            {NewQ, NewVisited};
                                        true ->
                                            {AccQ, AccVisited}
                                    end;
                                true ->
                                    {AccQ, AccVisited}
                            end
                        end,
                        {Q1, Visited}, Moves),
                    bfs(NewQ, NewVisited, Target)
            end
    end.

moves(I, J) ->
    [{0, 1}, {0, -1}, {1, 0}, {-1, 0}].

find_zero(State) ->
    find_zero(State, 0, 0).

find_zero(State, I, J) when J < 3 ->
    case element(I, J, State) of
        0 -> {I, J};
        _ -> find_zero(State, I, J + 1)
    end;
find_zero(State, I, _) when I < 1 ->
    find_zero(State, I + 1, 0);
find_zero(_, _, _) -> {-1, -1}.

swap(State, I1, J1, I2, J2) ->
    Val1 = element(I1, J1, State),
    Val2 = element(I2, J2, State),
    setelement(I1, setelement(J1, State, Val2), setelement(J2, State, Val1)).

element(I, J, State) ->
    element(J + 1, element(I + 1, State)).

to_tuple(Board) ->
    list_to_tuple([list_to_tuple(Row) || Row <- Board]).

to_list(State) ->
    [tuple_to_list(Row) || Row <- tuple_to_list(State)].