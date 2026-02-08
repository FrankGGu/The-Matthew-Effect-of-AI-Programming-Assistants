-module(longest_uncommon_subsequence).
-export([main/0]).

main() ->
    io:format("~p~n", [longest_uncommon_subsequence("a", "a")]).

longest_uncommon_subsequence(A, B) ->
    if
        A =/= B -> max(length(A), length(B));
        true -> -1
    end.