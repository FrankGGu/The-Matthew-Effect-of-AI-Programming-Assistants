-module(solution).
-export([catMouseGame/2]).

catMouseGame(Positions, Queries) ->
    Max = lists:max([lists:nth(1, Q) || Q <- Queries]),
    Mouse = lists:seq(0, Max),
    Cat = lists:seq(0, Max),
    Game = 3 * (Max + 1),
    State = array:new([{size, Game}, {default, 3}]),
    State1 = init_state(State, Positions),
    [solve(Query, State1) || Query <- Queries].

init_state(State, []) ->
    State;
init_state(State, [Pos | Rest]) ->
    [M, C, T] = Pos,
    Index = M * (length(Mouse) + 1) + C,
    State1 = array:set(Index, 2, State),
    init_state(State1, Rest).

solve([M, C, T], State) ->
    solve(M, C, T, State).

solve(M, C, T, State) ->
    Index = M * (length(Mouse) + 1) + C,
    case array:get(Index, State) of
        3 -> solve(M, C, T, State, 0);
        Val -> Val
    end.

solve(M, C, T, State, Step) ->
    if
        T == 0 -> 2;
        M == C -> 1;
        true ->
            Index = M * (length(Mouse) + 1) + C,
            case array:get(Index, State) of
                3 ->
                    NextT = T - 1,
                    Res = case Step of
                              0 -> 2;
                              _ -> 0
                          end,
                    NewState = array:set(Index, 2, State),
                    case solve_mouse(M, C, NextT, NewState) of
                        1 -> 1;
                        2 -> 2;
                        _ -> solve_cat(M, C, NextT, NewState)
                    end;
                Val -> Val
            end
    end.

solve_mouse(M, C, T, State) ->
    case step_mouse(M, C, T, State) of
        1 -> 1;
        2 -> 2;
        _ -> 0
    end.

step_mouse(M, C, T, State) ->
    NextM = M + 1,
    Index = NextM * (length(Mouse) + 1) + C,
    case array:get(Index, State) of
        1 -> 1;
        2 -> 2;
        3 -> solve(NextM, C, T, State);
        _ -> 0
    end.

solve_cat(M, C, T, State) ->
    case step_cat(M, C, T, State) of
        1 -> 1;
        2 -> 2;
        _ -> 0
    end.

step_cat(M, C, T, State) ->
    NextC = C + 1,
    Index = M * (length(Mouse) + 1) + NextC,
    case array:get(Index, State) of
        1 -> 1;
        2 -> 2;
        3 -> solve(M, NextC, T, State);
        _ -> 0
    end.