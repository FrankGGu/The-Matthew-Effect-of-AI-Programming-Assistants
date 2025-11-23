-module(solution).
-export([longest_palindrome/1]).

longest_palindrome(S) ->
    N = erlang:length(S),
    MaxLen = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                J > I + 1 ->
                    Sub = erlang:substring(S, I+1, J - I),
                    case is_palindrome(Sub) of
                        true -> max(erlang:length(Sub), Acc2);
                        false -> Acc2
                    end;
                true ->
                    Acc2
            end
        end, Acc, lists:seq(I+1, N))
    end, MaxLen, lists:seq(0, N-1)).

is_palindrome(S) ->
    S == lists:reverse(S).