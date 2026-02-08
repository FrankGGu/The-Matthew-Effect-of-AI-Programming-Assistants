-spec is_valid(Data :: [integer()]) -> boolean().
is_valid(Data) ->
    is_valid(Data, 0).

is_valid([], 0) -> true;
is_valid([], _) -> false;
is_valid([Byte | Rest], Expected) ->
    case Expected of
        0 ->
            case Byte of
                B when (B band 16#80) == 0 -> is_valid(Rest, 0);
                B when (B band 16#E0) == 16#C0 -> is_valid(Rest, 1);
                B when (B band 16#F0) == 16#E0 -> is_valid(Rest, 2);
                B when (B band 16#F8) == 16#F0 -> is_valid(Rest, 3);
                _ -> false
            end;
        _ ->
            case (Byte band 16#C0) == 16#80 of
                true -> is_valid(Rest, Expected - 1);
                false -> false
            end
    end.