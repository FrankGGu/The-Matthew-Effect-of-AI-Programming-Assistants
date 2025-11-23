-module(solution).
-export([second_largest_digit/1]).

second_largest_digit(Str) ->
    Digits = lists:filter(fun(C) -> C >= $0, C =< $9 end, string:to_list(Str)),
    UniqueDigits = lists:usort(Digits),
    case lists:reverse(UniqueDigits) of
        [_, Second | _] -> Second - $0;
        _ -> -1
    end.