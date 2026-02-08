-spec remove_duplicates(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
remove_duplicates(S, K) ->
    remove_duplicates(S, K, []).

remove_duplicates(<<>>, _, Stack) ->
    lists:reverse(Stack);
remove_duplicates(<<C:8, Rest/binary>>, K, []) ->
    remove_duplicates(Rest, K, [{C, 1}]);
remove_duplicates(<<C:8, Rest/binary>>, K, [{C, Count} | Tail]) ->
    NewCount = Count + 1,
    if
        NewCount == K ->
            remove_duplicates(Rest, K, Tail);
        true ->
            remove_duplicates(Rest, K, [{C, NewCount} | Tail])
    end;
remove_duplicates(<<C:8, Rest/binary>>, K, Stack) ->
    remove_duplicates(Rest, K, [{C, 1} | Stack]).

to_string(Stack) ->
    to_string(Stack, <<>>).

to_string([], Acc) ->
    Acc;
to_string([{C, Count} | Tail], Acc) ->
    Chars = binary:copy(<<C>>, Count),
    to_string(Tail, <<Chars/binary, Acc/binary>>).