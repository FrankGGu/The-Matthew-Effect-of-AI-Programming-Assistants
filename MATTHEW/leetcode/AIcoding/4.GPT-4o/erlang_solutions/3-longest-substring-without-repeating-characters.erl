-spec length_of_longest_substring(S :: unicode:unicode_binary()) -> integer().
length_of_longest_substring(S) ->
    length_of_longest_substring(S, 0, [], 0).

length_of_longest_substring([], MaxLen, _, MaxLen) -> MaxLen;
length_of_longest_substring([H | T], MaxLen, Seen, CurrentLen) ->
    case lists:member(H, Seen) of
        true ->
            length_of_longest_substring(T, MaxLen, [], 0);  % Reset seen characters
        false ->
            length_of_longest_substring(T, 
                                        max(MaxLen, CurrentLen + 1), 
                                        [H | Seen], 
                                        CurrentLen + 1)
    end.
