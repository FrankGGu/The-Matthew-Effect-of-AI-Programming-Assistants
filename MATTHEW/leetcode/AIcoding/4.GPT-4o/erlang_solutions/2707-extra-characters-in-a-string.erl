-module(solution).
-export([count_extra_chars/2]).

count_extra_chars(Str, Dict) ->
    count_extra_chars(Str, Dict, 0).

count_extra_chars([], _Dict, Count) ->
    Count;
count_extra_chars([H | T], Dict, Count) ->
    case lists:any(fun(X) -> string:prefix([H | T], X) end, Dict) of
        true -> count_extra_chars(T, Dict, Count);
        false -> count_extra_chars(T, Dict, Count + 1)
    end.