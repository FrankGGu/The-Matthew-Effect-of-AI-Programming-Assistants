-module(minimum_distance_to_type_a_word_using_two_fingers).
-export([minimumDistance/1]).

minimumDistance(Word) ->
    WordLength = length(Word),
    InitialState = {0, 0},
    Map = maps:from_list([{Char, Pos} || {Pos, Char} <- lists:zip(lists:seq(0, 25), "ABCDEFGHIJKLMNOPQRSTUVWXYZ")]),
    StateMap = maps:new(),
    doMinimumDistance(Word, 0, InitialState, Map, StateMap).

doMinimumDistance(_, _, {_, _} = State, _, _) when State == {0, 0} ->
    0;
doMinimumDistance([], _, _, _, _) ->
    0;
doMinimumDistance([H | T], Index, {Finger1, Finger2}, Map, StateMap) ->
    CharPos = maps:get(H, Map),
    NewStateMap = maps:put({Finger1, Finger2}, 0, StateMap),
    Distances = lists:foldl(fun
        (Finger, Acc) ->
            case Finger of
                Finger1 -> Acc;
                _ ->
                    Distance = distance(Finger, CharPos),
                    NewAcc = maps:put({Finger, Finger2}, Distance, Acc),
                    NewAcc
            end
    end, NewStateMap, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]),
    NextStates = maps:keys(Distances),
    MinDist = lists:min([maps:get(State, Distances) || State <- NextStates]),
    MinDist + doMinimumDistance(T, Index + 1, {CharPos, Finger2}, Map, StateMap).

distance(A, B) ->
    X1 = A rem 6,
    Y1 = A div 6,
    X2 = B rem 6,
    Y2 = B div 6,
    abs(X1 - X2) + abs(Y1 - Y2).