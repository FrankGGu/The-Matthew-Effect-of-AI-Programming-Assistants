-module(solution).
-export([find_and_replace_pattern/2]).

find_and_replace_pattern(Pattern, Words) ->
    lists:filter(fun(W) -> is_match(Pattern, W) end, Words).

is_match(P1, P2) ->
    maps:size(maps:from_list(associations(P1, P2))) == 2.

associations([], []) ->
    [];
associations([H1|T1], [H2|T2]) ->
    [{H1, H2} | associations(T1, T2)].