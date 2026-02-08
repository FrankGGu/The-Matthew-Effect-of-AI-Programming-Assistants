-spec my_atoi(S :: unicode:unicode_binary()) -> integer().
my_atoi(S) ->
    Trimmed = string:trim(S),
    case Trimmed of
        <<>> -> 0;
        _ ->
            {Sign, Rest} = case Trimmed of
                <<$-, Rest0/binary>> -> {-1, Rest0};
                <<$+, Rest0/binary>> -> {1, Rest0};
                _ -> {1, Trimmed}
            end,
            Digits = lists:takewhile(fun(C) -> C >= $0 andalso C =< $9 end, binary_to_list(Rest)),
            case Digits of
                [] -> 0;
                _ ->
                    Num = list_to_integer(Digits),
                    Result = Sign * Num,
                    if
                        Result > 2147483647 -> 2147483647;
                        Result < -2147483648 -> -2147483648;
                        true -> Result
                    end
            end
    end.