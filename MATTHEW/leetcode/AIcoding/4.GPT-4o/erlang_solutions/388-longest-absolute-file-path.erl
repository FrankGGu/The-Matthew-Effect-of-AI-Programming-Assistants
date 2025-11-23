-spec length_longest_path(Input :: unicode:unicode_binary()) -> integer().
length_longest_path(Input) ->
    length_longest_path(Input, 0, 0).

-spec length_longest_path(Input :: unicode:unicode_binary(), MaxLen :: integer(), CurrentLen :: integer()) -> integer().
length_longest_path([], MaxLen, _) -> MaxLen;
length_longest_path(["\n" | Rest], MaxLen, CurrentLen) -> 
    length_longest_path(Rest, MaxLen, 0);
length_longest_path(["\t" | Rest], MaxLen, CurrentLen) -> 
    length_longest_path(Rest, MaxLen, CurrentLen + 1);
length_longest_path([C | Rest], MaxLen, CurrentLen) when C =/= "\n", C =/= "\t" ->
    length_longest_path(Rest, MaxLen, CurrentLen + 1).
