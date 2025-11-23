-module(count_substrings).
-export([count_substrings/2]).

count_substrings(S, T) ->
    T_map = string_to_map(T),
    count(S, T_map, 0, 0).

count([], _T_map, Count, _T_len) -> Count;
count(S, T_map, Count, T_len) ->
    case lists:prefix(S, T) of
        true -> count(tl(S), T_map, Count + 1, T_len);
        false -> count(tl(S), T_map, Count, T_len)
    end.

string_to_map(Str) ->
    lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, #{}, string:to_list(Str)).