-module(solution).
-export([vowel_strings/2]).

vowel_strings(Names, Queries) ->
    Vowels = [&$a, &$e, &$i, &$o, &$u],
    Count = fun(Name) -> 
        First = lists:nth(1, Name),
        Last = lists:last(Name),
        lists:member(First, Vowels) andalso lists:member(Last, Vowels)
    end,
    Counts = lists:map(Count, Names),
    lists:foldl(fun({Q, C}, Acc) -> 
        case Q of
            {L, R} -> 
                lists:sum(lists:sublist(Counts, L, R - L + 1)) + Acc;
            _ -> Acc
        end
    end, 0, Queries).