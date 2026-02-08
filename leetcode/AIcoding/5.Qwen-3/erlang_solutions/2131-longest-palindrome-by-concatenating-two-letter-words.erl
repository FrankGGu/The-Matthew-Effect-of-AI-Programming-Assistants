-module(longest_palindrome).
-export([longest_palindrome/1]).

longest_palindrome(Words) ->
    Count = maps:from_list([{Word, 1} || Word <- Words]),
    Pairs = lists:foldl(fun(Word, Acc) ->
        case maps:get(Word, Acc, 0) of
            0 -> Acc;
            N -> maps:update(Word, N - 1, Acc)
        end
    end, Count, Words),
    Max = lists:foldl(fun({Word, _}, Acc) ->
        Rev = lists:reverse(Word),
        if
            Word == Rev -> max(Acc, 2);
            true -> Acc
        end
    end, 0, maps:to_list(Pairs)),
    Max + (if Max == 0 -> 0; true -> 0 end).

longest_palindrome(_Words) -> 0.