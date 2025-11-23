-spec count_substrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
count_substrings(S, K) ->
    N = byte_size(S),
    count_substrings(S, K, N, 0).

count_substrings(_S, _K, 0, Acc) -> Acc;
count_substrings(S, K, N, Acc) ->
    NewAcc = lists:foldl(fun(I, Sum) ->
        case is_valid_substring(S, I, N, K) of
            true -> Sum + 1;
            false -> Sum
        end
    end, Acc, lists:seq(1, N)),
    count_substrings(S, K, N - 1, NewAcc).

is_valid_substring(S, Start, End, K) ->
    Sub = binary:part(S, Start - 1, End - Start + 1),
    case count_chars(Sub, #{}) of
        {ok, Counts} ->
            case lists:any(fun({_, V}) -> V >= K end, maps:to_list(Counts)) of
                true -> true;
                false -> false
            end;
        _ -> false
    end.

count_chars(<<>>, Counts) -> {ok, Counts};
count_chars(<<C/utf8, Rest/binary>>, Counts) ->
    case maps:get(C, Counts, 0) of
        V -> count_chars(Rest, maps:put(C, V + 1, Counts))
    end.