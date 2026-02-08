-spec getCollisionTimes([[integer()]]) -> [float()].
getCollisionTimes(Cars) ->
    N = length(Cars),
    Stack = [],
    Times = lists:duplicate(N, -1.0),
    process_cars(lists:reverse(Cars), Stack, Times).

process_cars([], _, Times) -> Times;
process_cars([Car | Rest], Stack, Times) ->
    {Pos, Speed} = {lists:nth(1, Car), lists:nth(2, Car)},
    NewStack = process_stack(Stack, Pos, Speed, Times),
    NewTimes = case NewStack of
        [] -> Times;
        [{NextPos, NextSpeed, NextIndex} | _] ->
            Time = (NextPos - Pos) / (Speed - NextSpeed),
            setelement(NextIndex, Times, Time)
    end,
    process_cars(Rest, [{Pos, Speed, length(Rest) + 1} | NewStack], NewTimes).

process_stack([], _, _, _) -> [];
process_stack([{NextPos, NextSpeed, NextIndex} | Rest], Pos, Speed, Times) ->
    case Speed =< NextSpeed of
        true -> process_stack(Rest, Pos, Speed, Times);
        false ->
            Time = (NextPos - Pos) / (Speed - NextSpeed),
            case element(NextIndex, Times) =:= -1.0 orelse Time < element(NextIndex, Times) of
                true -> [{NextPos, NextSpeed, NextIndex} | Rest];
                false -> process_stack(Rest, Pos, Speed, Times)
            end
    end.