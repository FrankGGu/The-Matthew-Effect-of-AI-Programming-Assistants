-spec shortest_beautiful_substring(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
shortest_beautiful_substring(S, K) ->
    SList = binary_to_list(S),
    N = length(SList),
    MinLen = N + 1,
    Result = [],
    {MinLen1, Result1} = find_substrings(SList, 0, N, K, MinLen, Result),
    if
        MinLen1 =< N -> list_to_binary(Result1);
        true -> <<>>
    end.

find_substrings(S, Start, N, K, MinLen, Result) ->
    if
        Start >= N -> {MinLen, Result};
        true ->
            Count = 0,
            {NewMinLen, NewResult} = check_substring(S, Start, N, K, Count, MinLen, Result),
            find_substrings(S, Start + 1, N, K, NewMinLen, NewResult)
    end.

check_substring(S, I, N, K, Count, MinLen, Result) ->
    if
        I >= N ->
            if
                Count =:= K andalso (I - 1 - hd(Result) + 1 < MinLen) ->
                    {I - 1 - hd(Result) + 1, lists:sublist(S, hd(Result) + 1, I - hd(Result))};
                Count =:= K andalso (I - 1 - hd(Result) + 1 =:= MinLen) ->
                    Current = lists:sublist(S, hd(Result) + 1, I - hd(Result)),
                    if
                        Current < Result -> {MinLen, Current};
                        true -> {MinLen, Result}
                    end;
                true ->
                    {MinLen, Result}
            end;
        true ->
            Char = lists:nth(I + 1, S),
            if
                Char =:= $1 ->
                    if
                        Count =:= 0 -> check_substring(S, I + 1, N, K, Count + 1, MinLen, [I]);
                        true -> check_substring(S, I + 1, N, K, Count + 1, MinLen, Result)
                    end;
                true ->
                    check_substring(S, I + 1, N, K, Count, MinLen, Result)
            end
    end.