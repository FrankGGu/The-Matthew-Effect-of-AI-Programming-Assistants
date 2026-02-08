-module(solution).
-export([findConcatenatedWords/1]).

findConcatenatedWords(Words) ->
    WordSet = maps:from_list([{W, true} || W <- Words]),
    lists:foldl(fun(Word, Acc) ->
        TempWordSet = maps:remove(Word, WordSet),
        case is_concatenated(Word, TempWordSet) of
            true -> [Word | Acc];
            false -> Acc
        end
    end, [], Words).

is_concatenated(Word, WordSet) ->
    Len = length(Word),
    DP = array:new([{size, Len + 1}, {default, false}]),
    DP1 = array:set(Len, true, DP), % DP[Len] is true (empty string can be formed)

    % Iterate I from Len-1 down to 0
    FinalDP = lists:foldl(fun(I, CurrentDP) ->
        % For each I, check if DP[I] can be set to true by iterating J
        check_j_loop(I, I + 1, Len, Word, WordSet, CurrentDP)
    end, DP1, lists:reverse(lists:seq(0, Len - 1))),

    array:get(0, FinalDP).

check_j_loop(I, J, Len, Word, WordSet, DP) when J =< Len ->
    case array:get(J, DP) of
        true ->
            Prefix = string:substr(Word, I + 1, J - I),
            case maps:is_key(Prefix, WordSet) of
                true ->
                    array:set(I, true, DP); % Found a way, set DP[I] to true and return
                false ->
                    check_j_loop(I, J + 1, Len, Word, WordSet, DP) % Continue checking J
            end;
        false ->
            check_j_loop(I, J + 1, Len, Word, WordSet, DP) % Continue checking J
    end;
check_j_loop(_I, _J, _Len, _Word, _WordSet, DP) ->
    DP. % No more J to check for this I, DP[I] remains false (or was already true)