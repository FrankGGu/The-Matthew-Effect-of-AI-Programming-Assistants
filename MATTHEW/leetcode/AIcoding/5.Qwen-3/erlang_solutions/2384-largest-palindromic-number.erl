-module(largest_palindromic_number).
-export([largest_palindromic/1]).

largest_palindromic(Num) ->
    Str = integer_to_list(Num),
    Len = length(Str),
    Max = lists:foldl(fun(I, Acc) -> max(Acc, list_to_integer([lists:nth(I, Str)])) end, -1, lists:seq(1, Len)),
    if
        Max == -1 -> [];
        true -> 
            Digits = lists:seq(0, 9),
            Count = lists:foldl(fun(D, Acc) -> 
                CountD = lists:foldl(fun(C, A) -> if C == D -> A + 1; true -> A end end, 0, Str),
                dict:store(D, CountD, Acc)
            end, dict:new(), Digits),
            Left = [],
            Right = [],
            build_palindrome(Count, Left, Right, []),
            lists:reverse(Right)
    end.

build_palindrome(_Count, _Left, _Right, []) -> [];
build_palindrome(Count, Left, Right, [D | Rest]) ->
    case dict:fetch(D, Count) of
        0 -> build_palindrome(Count, Left, Right, Rest);
        N when N >= 2 ->
            NewCount = dict:update(D, fun(V) -> V - 2 end, Count),
            build_palindrome(NewCount, [D | Left], [D | Right], Rest);
        _ -> build_palindrome(Count, Left, Right, Rest)
    end.