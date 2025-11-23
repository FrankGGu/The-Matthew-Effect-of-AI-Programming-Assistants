-module(solution).
-export([close/2]).

close(Str1, Str2) ->
    case length(Str1) == length(Str2) of
        false -> false;
        true ->
            Freq1 = frequency(Str1),
            Freq2 = frequency(Str2),
            Freq1 == Freq2.
    end.

frequency(Str) ->
    lists:foldl(fun(C, Acc) -> 
        Map = maps:update_with(C, fun(X) -> X + 1 end, 1, Acc)
    end, maps:new(), Str).