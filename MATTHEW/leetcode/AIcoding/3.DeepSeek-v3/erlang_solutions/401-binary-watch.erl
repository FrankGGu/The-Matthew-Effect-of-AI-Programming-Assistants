-spec read_binary_watch(TurnedOn :: integer()) -> [unicode:unicode_binary()].
read_binary_watch(TurnedOn) ->
    Result = [],
    lists:foldl(fun(H, Acc) ->
        lists:foldl(fun(M, Acc1) ->
            case count_ones(H) + count_ones(M) of
                TurnedOn ->
                    Time = format_time(H, M),
                    [Time | Acc1];
                _ ->
                    Acc1
            end
        end, Acc, lists:seq(0, 59))
    end, Result, lists:seq(0, 11)).

count_ones(N) ->
    count_ones(N, 0).

count_ones(0, Count) -> Count;
count_ones(N, Count) ->
    count_ones(N bsr 1, Count + (N band 1)).

format_time(H, M) ->
    case M < 10 of
        true -> 
            <<(integer_to_binary(H))/binary, ":0", (integer_to_binary(M))/binary>>;
        false ->
            <<(integer_to_binary(H))/binary, ":", (integer_to_binary(M))/binary>>
    end.