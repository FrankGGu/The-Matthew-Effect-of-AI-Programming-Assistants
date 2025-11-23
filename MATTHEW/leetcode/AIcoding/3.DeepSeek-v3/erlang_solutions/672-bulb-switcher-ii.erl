-spec flip_lights(N :: integer(), M :: integer()) -> integer().
flip_lights(N, M) ->
    case N of
        0 -> 0;
        1 ->
            case M of
                0 -> 1;
                _ -> 2
            end;
        2 ->
            case M of
                0 -> 1;
                1 -> 3;
                _ -> 4
            end;
        _ ->
            case M of
                0 -> 1;
                1 -> 4;
                2 -> 7;
                _ -> 8
            end
    end.