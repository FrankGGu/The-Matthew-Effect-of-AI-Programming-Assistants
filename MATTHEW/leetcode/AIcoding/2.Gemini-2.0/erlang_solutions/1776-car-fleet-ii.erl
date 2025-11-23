-module(car_fleet_ii).
-export([get_collision_times/1]).

get_collision_times(cars) ->
    get_collision_times(cars, [], []).

get_collision_times([], Stack, Acc) ->
    lists:reverse(Acc);
get_collision_times([Car | Rest], Stack, Acc) ->
    {CollisionTime, NewStack} = process_car(Car, Stack),
    get_collision_times(Rest, NewStack, [CollisionTime | Acc]).

process_car({Pos, Speed}, Stack) ->
    process_car({Pos, Speed}, Stack, infinity).

process_car({Pos, Speed}, [], CollisionTime) ->
    {{Pos, Speed, CollisionTime}, [{Pos, Speed}]};
process_car({Pos, Speed}, [{PrevPos, PrevSpeed} | Rest], CollisionTime) ->
    if
        Speed >= PrevSpeed ->
            process_car({Pos, Speed}, Rest, CollisionTime);
        true ->
            Time = (PrevPos - Pos) / (Speed - PrevSpeed),
            if
                Time >= CollisionTime ->
                    {{Pos, Speed, CollisionTime}, [{Pos, Speed}]};
                true ->
                    process_car({Pos, Speed}, Rest, min(Time, CollisionTime), {PrevPos, PrevSpeed}, Time)
            end
    end.

process_car({Pos, Speed}, [{PrevPos, PrevSpeed} | Rest], CollisionTime, {PrevPos2, PrevSpeed2}, Time) ->
    if
        Speed >= PrevSpeed ->
            process_car({Pos, Speed}, Rest, CollisionTime);
        true ->
            Time2 = (PrevPos - Pos) / (Speed - PrevSpeed),
            if
                Time2 >= CollisionTime ->
                    {{Pos, Speed, CollisionTime}, [{Pos, Speed}]};
                true ->
                    process_car({Pos, Speed}, Rest, min(Time2, CollisionTime), {PrevPos, PrevSpeed}, Time2)
            end
    end.

process_car({Pos, Speed}, [{PrevPos, PrevSpeed} | Rest], CollisionTime, {PrevPos2, PrevSpeed2}, Time) when Time < CollisionTime ->
    if
        Speed >= PrevSpeed ->
            process_car({Pos, Speed}, Rest, CollisionTime);
        true ->
            Time2 = (PrevPos - Pos) / (Speed - PrevSpeed),
            if
                Time2 >= CollisionTime ->
                    {{Pos, Speed, CollisionTime}, [{Pos, Speed}]};
                true ->
                   process_car({Pos, Speed}, Rest, min(Time2, CollisionTime), {PrevPos, PrevSpeed}, Time2)
            end
    end.

process_car({Pos, Speed}, Stack, CollisionTime, {PrevPos, PrevSpeed}, Time) ->
    NewStack = [{Pos, Speed} | Stack],
    {{Pos, Speed, Time}, NewStack}.

process_car({Pos, Speed}, Stack, CollisionTime) ->
    process_car({Pos, Speed}, Stack, Stack, CollisionTime, []).

process_car({Pos, Speed}, [], Stack, CollisionTime, Acc) ->
    {{Pos, Speed, CollisionTime}, [{Pos, Speed}] ++ Acc};
process_car({Pos, Speed}, [{PrevPos, PrevSpeed} | Rest], Stack, CollisionTime, Acc) ->
    if
        Speed >= PrevSpeed ->
             process_car({Pos, Speed}, Rest, Stack, CollisionTime, Acc);
        true ->
            Time = (PrevPos - Pos) / (Speed - PrevSpeed),
            if
                Time >= CollisionTime ->
                   {{Pos, Speed, CollisionTime}, [{Pos, Speed}] ++ Acc};
                true ->
                    process_stack({Pos, Speed}, Stack, Time, Acc)
            end
    end.

process_stack({Pos, Speed}, Stack, Time, Acc) ->
     process_stack({Pos, Speed}, Stack, [], Time, Acc).

process_stack({Pos, Speed}, [], Stack, Time, Acc) ->
    {{Pos, Speed, Time}, [{Pos, Speed}] ++ Acc};
process_stack({Pos, Speed}, [{PrevPos, PrevSpeed} | Rest], Stack, Time, Acc) ->
     if
        Speed >= PrevSpeed ->
            process_stack({Pos, Speed}, Rest, Stack, Time, Acc);
        true ->
            Time2 = (PrevPos - Pos) / (Speed - PrevSpeed),
            if
                Time2 >= Time ->
                   {{Pos, Speed, Time}, [{Pos, Speed}] ++ Acc};
                true ->
                    process_stack({Pos, Speed}, Rest, Stack, Time, Acc)
            end
    end.

infinity() ->
    1.0e308.