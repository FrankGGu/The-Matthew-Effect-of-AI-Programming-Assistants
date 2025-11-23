-module(solution).
-export([count_beautiful_substrings/1]).

count_beautiful_substrings(Str) ->
    N = erlang:length(Str),
    Count = 0,
    List = lists:seq(0, N-1),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                J > I ->
                    Sub = lists:sublist(Str, I+1, J-I),
                    IsPalindrome = is_palindrome(Sub),
                    IsEvenLength = (erlang:length(Sub) rem 2) == 0,
                    if
                        IsPalindrome andalso IsEvenLength ->
                            Acc2 + 1;
                        true ->
                            Acc2
                    end;
                true ->
                    Acc2
            end
        end, Acc, List)
    end, Count, List).

is_palindrome(List) ->
    List == lists:reverse(List).