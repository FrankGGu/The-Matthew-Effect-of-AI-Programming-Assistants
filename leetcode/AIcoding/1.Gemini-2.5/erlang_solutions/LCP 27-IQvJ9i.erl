-module(solution).
-export([black_box_light_reflection/3]).

-define(DX, {0, 1, 0, -1}).
-define(DY, {-1, 0, 1, 0}).

black_box_light_reflection(N, StartList, MirrorsList) ->
    StartTuple = list_to_tuple_start(StartList),
    MirrorMap = build_mirror_map(MirrorsList),
    simulate(N, StartTuple, MirrorMap).

list_to_tuple_start([X, Y, Dir]) -> {X, Y, Dir}.

build_mirror_map(MirrorsList) ->
    lists:foldl(fun([X, Y, Type], Acc) ->
                        Acc#{ {X, Y} => Type }
                end, #{}, MirrorsList).

simulate(N, {X, Y, Dir}, MirrorMap) ->
    if
        X < 0; X >= N; Y < 0; Y >= N ->
            [X, Y, Dir];
        true ->
            case maps:find({X, Y}, MirrorMap) of
                {ok, MirrorType} ->
                    NewDir = reflect(Dir, MirrorType),
                    NextX = X + element(NewDir + 1, ?DX),
                    NextY = Y + element(NewDir + 1, ?DY),
                    simulate(N, {NextX, NextY, NewDir}, MirrorMap);
                error ->
                    NextX = X + element(Dir + 1, ?DX),
                    NextY = Y + element(Dir + 1, ?DY),
                    simulate(N, {NextX, NextY, Dir}, MirrorMap)
            end
    end.

reflect(Dir, MirrorType) ->
    case MirrorType of
        0 ->
            case Dir of
                0 -> 1;
                1 -> 0;
                2 -> 3;
                3 -> 2
            end;
        1 ->
            case Dir of
                0 -> 3;
                1 -> 2;
                2 -> 1;
                3 -> 0
            end
    end.