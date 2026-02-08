-spec min_operations(N :: integer()) -> integer().
min_operations(N) ->
    min_operations(N, 0).

min_operations(0, Acc) -> Acc;
min_operations(N, Acc) ->
    case N band 1 of
        1 ->
            case (N band 2) of
                0 -> min_operations(N - 1, Acc + 1);
                _ -> min_operations(N + 1, Acc + 1)
            end;
        0 -> min_operations(N bsr 1, Acc)
    end.