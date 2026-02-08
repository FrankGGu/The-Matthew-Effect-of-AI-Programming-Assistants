-module(solution).
-export([vowel_strings/2]).

vowel_strings(Queries, S) ->
    Vowels = [&quot;a&quot;, &quot;e&quot;, &quot;i&quot;, &quot;o&quot;, &quot;u&quot;],
    N = length(S),
    Pre = precompute(Vowels, S, 0, []),
    [count(Pre, Q) || Q <- Queries].

precompute(_, [], _, Acc) -> Acc;
precompute(Vowels, [C | T], I, Acc) ->
    Count = lists:foldl(fun(V, Sum) -> Sum + (if C == V -> 1; true -> 0 end) end, 0, Vowels),
    precompute(Vowels, T, I + 1, [Count | Acc]).

count(Pre, {L, R}) ->
    lists:sum(lists:sublist(Pre, L, R - L + 1)).

vowel_strings(Queries) ->
    vowel_strings(Queries, "abcde").