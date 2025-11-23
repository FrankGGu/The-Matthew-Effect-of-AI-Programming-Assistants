-module(solution).
-export([max_palindromes/1]).

max_palindromes(Str) ->
    N = string:length(Str),
    DP = lists:duplicate(N, lists:duplicate(N, false)),
    Palindromes = find_palindromes(Str, DP, N),
    count_non_overlapping(Palindromes, 0, 0).

find_palindromes(Str, DP, N) ->
    Palindromes = lists:foldl(fun(_, Acc) -> 
        lists:foldl(fun(I, Acc1) -> 
            lists:foldl(fun(J, Acc2) -> 
                case is_palindrome(Str, I, J) of
                    true -> [{I, J} | Acc2];
                    false -> Acc2
                end
            end, Acc1, lists:seq(I, N))
        end, Acc, lists:seq(1, N))
    end, [], lists:seq(1, N),
    lists:reverse(Palindromes).

is_palindrome(Str, I, J) ->
    Substr = string:substr(Str, I, J - I + 1),
    Substr == string:reverse(Substr).

count_non_overlapping([], Count, Max) -> Max;
count_non_overlapping([{I, J} | T], Count, Max) ->
    if
        I > Count -> count_non_overlapping(T, J, Max + 1);
        true -> count_non_overlapping(T, Count, Max)
    end.