-module(solution).
-export([find_min_step/2]).

find_min_step(Board, Hand) ->
    HandCount = count_hand(Hand, #{}),
    dfs(Board, HandCount, 0, infinity).

dfs([], _, Steps, MinSteps) ->
    min(Steps, MinSteps);
dfs(Board, Hand, Steps, MinSteps) when Steps >= MinSteps ->
    MinSteps;
dfs(Board, Hand, Steps, MinSteps) ->
    case remove_consecutive(Board) of
        [] ->
            min(Steps, MinSteps);
        NewBoard ->
            NewMin = lists:foldl(
                fun(Color, AccMin) ->
                    case maps:get(Color, Hand, 0) of
                        0 -> AccMin;
                        Count ->
                            NewHand = maps:update(Color, Count - 1, Hand),
                            NewSteps = Steps + 1,
                            dfs([Color | NewBoard], NewHand, NewSteps, AccMin)
                    end
                end,
                MinSteps,
                [<<"R">>, <<"Y">>, <<"B">>, <<"G">>, <<"W">>]
            ),
            NewMin
    end.

count_hand([], Map) -> Map;
count_hand([Color | Rest], Map) ->
    NewMap = maps:update_with(Color, fun(V) -> V + 1 end, 1, Map),
    count_hand(Rest, NewMap).

remove_consecutive(Board) ->
    case find_consecutive(Board) of
        {Start, Len} ->
            NewBoard = lists:sublist(Board, 1, Start - 1) ++ lists:nthtail(Start + Len - 1, Board),
            remove_consecutive(NewBoard);
        none ->
            Board
    end.

find_consecutive(Board) ->
    find_consecutive(Board, 1, 1).

find_consecutive([], _, _) -> none;
find_consecutive([_], Start, Len) when Len >= 3 -> {Start, Len};
find_consecutive([_], _, _) -> none;
find_consecutive([C, C | Rest], Start, Len) ->
    find_consecutive([C | Rest], Start, Len + 1);
find_consecutive([_, Next | Rest], Start, Len) when Len >= 3 ->
    {Start, Len};
find_consecutive([_, Next | Rest], Start, Len) ->
    find_consecutive([Next | Rest], Start + Len, 1).