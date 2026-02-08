-module(solution).
-export([longestDecomposition/1]).

longestDecomposition(Text) ->
    solve(Text).

solve(Text) ->
    N = string:len(Text),
    if
        N == 0 ->
            0;
        true ->
            find_match(Text, N, 1)
    end.

find_match(Text, N, L) when L =< N div 2 ->
    Prefix = string:substr(Text, 1, L),
    Suffix = string:substr(Text, N - L + 1, L),
    if
        Prefix == Suffix ->
            Middle = string:substr(Text, L + 1, N - 2*L),
            2 + solve(Middle);
        true ->
            find_match(Text, N, L + 1)
    end;
find_match(_Text, _N, _L) ->
    1.