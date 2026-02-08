-module(solution).
-export([removeDuplicates/2]).

removeDuplicates(S, K) ->
    process(S, K, []).

process([], _K, Stack) ->
    lists:reverse(
        lists:flatmap(
            fun({Char, Count}) ->
                lists:duplicate(Count, Char)
            end,
            Stack
        )
    );
process([Char|Rest], K, []) ->
    process(Rest, K, [{Char, 1}]);
process([Char|Rest], K, [{Char, Count}|StackTail]) when Count + 1 == K ->
    process(Rest, K, StackTail);
process([Char|Rest], K, [{Char, Count}|StackTail]) ->
    process(Rest, K, [{Char, Count + 1}|StackTail]);
process([Char|Rest], K, Stack) ->
    process(Rest, K, [{Char, 1}|Stack]).