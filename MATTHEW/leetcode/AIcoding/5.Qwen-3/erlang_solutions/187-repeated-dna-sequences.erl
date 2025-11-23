-module(repeated_dna_sequences).
-export([find_repeated_dna_sequences/1]).

find_repeated_dna_sequences(S) ->
    N = length(S),
    Set = sets:new(),
    Result = sets:new(),
    find_repeated_dna_sequences(S, 0, N, Set, Result).

find_repeated_dna_sequences(_, _, N, _, _) when N < 10 ->
    lists:sort(sets:to_list(Result));
find_repeated_dna_sequences(S, I, N, Set, Result) ->
    if
        I + 9 < N ->
            Sub = string:substr(S, I + 1, 10),
            case sets:is_element(Sub, Set) of
                true ->
                    find_repeated_dna_sequences(S, I + 1, N, Set, sets:add_element(Sub, Result));
                false ->
                    find_repeated_dna_sequences(S, I + 1, N, sets:add_element(Sub, Set), Result)
            end;
        true ->
            lists:sort(sets:to_list(Result))
    end.