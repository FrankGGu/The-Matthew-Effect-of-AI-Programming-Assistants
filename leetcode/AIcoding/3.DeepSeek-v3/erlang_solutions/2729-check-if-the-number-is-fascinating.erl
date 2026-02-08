-spec is_fascinating(N :: integer()) -> boolean().
is_fascinating(N) ->
    Concatenated = integer_to_list(N) ++ integer_to_list(2 * N) ++ integer_to_list(3 * N),
    case length(Concatenated) of
        9 ->
            case lists:sort(Concatenated) of
                "123456789" -> true;
                _ -> false
            end;
        _ -> false
    end.