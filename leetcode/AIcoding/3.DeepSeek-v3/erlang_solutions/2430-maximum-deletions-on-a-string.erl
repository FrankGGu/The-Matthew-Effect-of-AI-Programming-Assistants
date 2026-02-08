-spec max_operations(S :: unicode:unicode_binary()) -> integer().
max_operations(S) ->
    N = byte_size(S),
    DP = array:new([{size, N + 1}, {default, 0}]),
    max_operations(S, N, DP).

max_operations(S, N, DP) ->
    case N of
        0 -> 0;
        1 -> 1;
        _ ->
            case array:get(N, DP) of
                0 ->
                    Max = lists:max([
                        1 + max_operations(S, N - 1, DP),
                        case N >= 2 andalso binary:part(S, {0, N div 2}) =:= binary:part(S, {N div 2, N div 2}) of
                            true -> 1 + max_operations(S, N div 2, DP);
                            false -> 0
                        end
                    ]),
                    NewDP = array:set(N, Max, DP),
                    max_operations(S, N, NewDP);
                Val -> Val
            end
    end.