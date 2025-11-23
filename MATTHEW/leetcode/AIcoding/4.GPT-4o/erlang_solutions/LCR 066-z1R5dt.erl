-module(Solution).
-export([findRepeatedDnaSequences/1]).

findRepeatedDnaSequences(S) ->
    find_repeated_dna_sequences(S, [], #{}).

find_repeated_dna_sequences([], Acc, _) -> 
    lists:reverse(Acc);
find_repeated_dna_sequences(Str, Acc, Seen) ->
    case string:length(Str) >= 10 of
        false -> 
            lists:reverse(Acc);
        true -> 
            Sequence = string:substr(Str, 1, 10),
            case maps:is_key(Sequence, Seen) of
                true -> 
                    find_repeated_dna_sequences(string:substr(Str, 2, string:length(Str) - 1), 
                                                 lists:duplicate(Sequence), 
                                                 maps:put(Sequence, true, Seen));
                false -> 
                    find_repeated_dna_sequences(string:substr(Str, 2, string:length(Str) - 1), 
                                                 Acc, 
                                                 maps:put(Sequence, true, Seen))
            end
    end.