-spec remove_adjacent_duplicates(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
remove_adjacent_duplicates(S, K) ->
    remove_adjacent_duplicates(S, K, []).

remove_adjacent_duplicates(<<>>, _, Stack) ->
    lists:reverse(Stack);
remove_adjacent_duplicates(<<C:8, Rest/binary>>, K, [{C, Count} | StackTail]) when Count + 1 == K ->
    remove_adjacent_duplicates(Rest, K, StackTail);
remove_adjacent_duplicates(<<C:8, Rest/binary>>, K, [{C, Count} | StackTail]) ->
    remove_adjacent_duplicates(Rest, K, [{C, Count + 1} | StackTail]);
remove_adjacent_duplicates(<<C:8, Rest/binary>>, K, Stack) ->
    remove_adjacent_duplicates(Rest, K, [{C, 1} | Stack]).