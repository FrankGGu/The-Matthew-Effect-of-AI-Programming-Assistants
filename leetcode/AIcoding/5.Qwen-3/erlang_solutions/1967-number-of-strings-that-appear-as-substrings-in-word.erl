-module(solution).
-export([num_of_strings/2]).

num_of_strings(Word, Strings) ->
    Count = 0,
    lists:foldl(fun(Str, Acc) -> 
        case string:contains(Word, Str) of
            true -> Acc + 1;
            false -> Acc
        end
    end, Count, Strings).