-spec min_insertions(S :: unicode:unicode_binary()) -> integer().
min_insertions(S) ->
    N = byte_size(S),
    DP = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Row) ->
            case I >= J of
                true -> 0;
                false ->
                    case binary:at(S, I - 1) =:= binary:at(S, N - J) of
                        true -> lists:nth(J - 1, Row);
                        false -> 1 + min(lists:nth(J, Row), lists:nth(J - 1, lists:nth(I + 1, Acc)))
                    end
            end
        end, lists:duplicate(N + 1, 0), lists:seq(1, N))
    end, lists:duplicate(N + 1, lists:duplicate(N + 1, 0)), lists:seq(1, N)),
    lists:nth(N, lists:nth(N, DP)).