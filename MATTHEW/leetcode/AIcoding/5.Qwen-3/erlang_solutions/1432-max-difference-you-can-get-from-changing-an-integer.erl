-module(solution).
-export([maxDiff/1]).

maxDiff(N) ->
    Str = integer_to_list(N),
    Len = length(Str),
    Max = lists:seq(0, Len - 1),
    Min = lists:seq(0, Len - 1),
    lists:max([lists:foldl(fun(I, Acc) -> 
        case lists:nth(I + 1, Str) of
            $9 -> Acc;
            _ -> 
                NewStr = lists:sublist(Str, I) ++ [lists:nth(I + 1, Str) + 1] ++ lists:duplicate(Len - I - 1, $0),
                Val = list_to_integer(NewStr),
                max(Acc, Val - N)
        end
    end, 0, Max) || I <- Min]).

-maxDiff/1.