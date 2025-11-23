-module(find_palindrome).
-export([kth_palindrome/2]).

kth_palindrome(Queries, IntLength) ->
    lists:map(fun(Q) -> kth_palindrome_single(Q, IntLength) end, Queries).

kth_palindrome_single(K, IntLength) ->
    HalfLength = (IntLength + 1) div 2,
    Start = erlang:trunc(math:pow(10, HalfLength - 1)),
    Max = erlang:trunc(math:pow(10, HalfLength)) - 1,
    Num = Start + K - 1,

    if Num > Max then
        -1
    else
        Half = integer_to_list(Num),
        if IntLength rem 2 == 0 then
            Half ++ lists:reverse(Half)
        else
            Half ++ lists:reverse(tl(Half))
        end
    end.