-module(max_palindromes_after_operations).
-export([longest_palindrome/1]).

longest_palindrome(Str) ->
    Count = lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), Str),
    {OddCount, EvenCount} = lists:foldl(fun({_, V}, {Odd, Even}) ->
        if
            V rem 2 == 1 -> {Odd + 1, Even};
            true -> {Odd, Even + V}
        end
    end, {0, 0}, dict:to_list(Count)),
    case OddCount of
        0 -> EvenCount;
        _ -> EvenCount + 1
    end.