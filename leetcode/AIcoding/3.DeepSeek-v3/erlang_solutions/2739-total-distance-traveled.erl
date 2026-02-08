-spec distance_traveled(MainTank :: integer(), AdditionalTank :: integer()) -> integer().
distance_traveled(MainTank, AdditionalTank) ->
    distance_traveled(MainTank, AdditionalTank, 0).

distance_traveled(0, _, Distance) -> Distance;
distance_traveled(MainTank, AdditionalTank, Distance) ->
    case MainTank >= 1 of
        true ->
            NewMainTank = MainTank - 1,
            NewDistance = Distance + 10,
            case (NewDistance rem 50) =:= 0 andalso AdditionalTank >= 1 of
                true ->
                    distance_traveled(NewMainTank + 1, AdditionalTank - 1, NewDistance);
                false ->
                    distance_traveled(NewMainTank, AdditionalTank, NewDistance)
            end;
        false ->
            Distance
    end.