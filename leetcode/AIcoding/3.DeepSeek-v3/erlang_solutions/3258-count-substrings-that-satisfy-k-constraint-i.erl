-spec count_substrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
count_substrings(S, K) ->
    N = byte_size(S),
    Count = 0,
    count_substrings(S, K, N, Count).

count_substrings(_, _, 0, Count) -> Count;
count_substrings(S, K, N, Count) ->
    NewCount = count_for_length(S, K, N, 0),
    count_substrings(S, K, N - 1, Count + NewCount).

count_for_length(S, K, Len, Start) ->
    case Start + Len > byte_size(S) of
        true -> 0;
        false ->
            Substring = binary:part(S, Start, Len),
            case satisfies_k(Substring, K) of
                true -> 1 + count_for_length(S, K, Len, Start + 1);
                false -> count_for_length(S, K, Len, Start + 1)
            end
    end.

satisfies_k(Substring, K) ->
    Chars = binary_to_list(Substring),
    Freq = lists:foldl(fun(Char, Acc) ->
                           maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, Chars),
    lists:any(fun({_, V}) -> V >= K end, maps:to_list(Freq)).