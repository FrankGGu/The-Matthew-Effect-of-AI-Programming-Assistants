-module(repeated_dna_sequences).
-export([find_repeated_dna_sequences/1]).

find_repeated_dna_sequences(S) ->
    find_repeated_dna_sequences(S, #{}, []).

find_repeated_dna_sequences(S, Seen, Acc) ->
    Len = length(S),
    if Len < 10 ->
        lists:reverse(Acc)
    else
        Sub = lists:sublist(S, 1, 10),
        case maps:is_key(Sub, Seen) of
            true ->
                case lists:member(Sub, Acc) of
                    true ->
                        find_repeated_dna_sequences(lists:nthtail(1, S), Seen, Acc);
                    false ->
                        find_repeated_dna_sequences(lists:nthtail(1, S), Seen, [Sub|Acc])
                end;
            false ->
                find_repeated_dna_sequences(lists:nthtail(1, S), maps:put(Sub, true, Seen), Acc)
        end
    end.