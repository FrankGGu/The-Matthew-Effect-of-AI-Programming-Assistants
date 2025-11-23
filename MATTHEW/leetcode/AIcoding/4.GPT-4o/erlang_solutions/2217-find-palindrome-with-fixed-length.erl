-module(solution).
-export([palindrome_of_fixed_length/2]).

palindrome_of_fixed_length(N, K) when K rem 2 =:= 0, K > 0 ->
    {ok, Base} = lists:foldl(fun(_, {C, Acc}) -> {C + 1, [C | Acc]} end, {0, []}, lists:seq(1, K div 2)),
    Palindrome = lists:concat([Base, lists:reverse(Base)]),
    Palindrome;
palindrome_of_fixed_length(N, K) when K rem 2 =:= 1, K > 0 ->
    {ok, Base} = lists:foldl(fun(_, {C, Acc}) -> {C + 1, [C | Acc]} end, {0, []}, lists:seq(1, (K div 2) + 1)),
    Palindrome = lists:concat([Base, lists:reverse(tl(Base))]),
    Palindrome;
palindrome_of_fixed_length(_, _) -> [].