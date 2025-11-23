-spec my_atoi(S :: unicode:unicode_binary()) -> integer().
my_atoi(S) ->
    S1 = string:trim(S),
    case S1 of
        <<>> -> 0;
        _ ->
            {Sign, Rest} = case S1 of
                <<$-, Rest0/binary>> -> {-1, Rest0};
                <<$+, Rest0/binary>> -> {1, Rest0};
                _ -> {1, S1}
            end,
            Digits = lists:takewhile(fun(C) -> C >= $0 andalso C =< $9 end, binary_to_list(Rest)),
            case Digits of
                [] -> 0;
                _ ->
                    Num = list_to_integer(Digits),
                    Result = Sign * Num,
                    if
                        Result < -2147483648 -> -2147483648;
                        Result > 2147483647 -> 2147483647;
                        true -> Result
                    end
            end
    end.