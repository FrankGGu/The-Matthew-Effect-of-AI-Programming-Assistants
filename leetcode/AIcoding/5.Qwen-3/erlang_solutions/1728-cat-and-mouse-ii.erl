-module(solution).
-export([cat_mouse_game/2]).

cat_mouse_game(Board, K) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    StateMap = maps:new(),
    {CatX, CatY} = find_pos(Board, $C),
    {MouseX, MouseY} = find_pos(Board, $M),
    {FoodX, FoodY} = find_pos(Board, $F),
    MaxSteps = K,
    Result = dfs(CatX, CatY, MouseX, MouseY, 0, MaxSteps, Board, Rows, Cols, StateMap, FoodX, FoodY),
    case Result of
        1 -> 1;
        0 -> 0;
        _ -> 2
    end.

find_pos([], _) -> {0, 0};
find_pos([Row | Rest], Target) ->
    case lists:keysearch(Target, 1, Row) of
        {value, {_, Pos}} -> {Pos, length(Rest)};
        false -> find_pos(Rest, Target)
    end.

dfs(CatX, CatY, MouseX, MouseY, Step, MaxSteps, Board, Rows, Cols, StateMap, FoodX, FoodY) ->
    Key = {CatX, CatY, MouseX, MouseY, Step},
    case maps:is_key(Key, StateMap) of
        true -> maps:get(Key, StateMap);
        false ->
            if
                Step >= MaxSteps -> 2;
                (CatX == FoodX andalso CatY == FoodY) -> 1;
                (MouseX == FoodX andalso MouseY == FoodY) -> 0;
                true ->
                    NextStep = Step + 1,
                    MoveList = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    Results = [dfs(CatX + DX, CatY + DY, MouseX + DMX, MouseY + DMY, NextStep, MaxSteps, Board, Rows, Cols, StateMap, FoodX, FoodY) || {DX, DY} <- MoveList, {DMX, DMY} <- MoveList, is_valid(CatX + DX, CatY + DY, Rows, Cols, Board), is_valid(MouseX + DMX, MouseY + DMY, Rows, Cols, Board)],
                    Res = case Results of
                              [] -> 2;
                              _ ->
                                  case lists:all(fun(X) -> X == 1 end, Results) of
                                      true -> 1;
                                      false ->
                                          case lists:any(fun(X) -> X == 0 end, Results) of
                                              true -> 0;
                                              false -> 2
                                          end
                                  end
                          end,
                    NewStateMap = maps:put(Key, Res, StateMap),
                    Res
            end
    end.

is_valid(X, Y, Rows, Cols, Board) ->
    X >= 0 andalso X < Rows andalso Y >= 0 andalso Y < Cols andalso lists:nth(X + 1, Board) -- [Y] /= $#.

lists:nth(1, List) -> hd(List);
lists:nth(N, List) when N > 1 -> lists:nth(N - 1, tl(List)).

lists:--([A], B) -> A.