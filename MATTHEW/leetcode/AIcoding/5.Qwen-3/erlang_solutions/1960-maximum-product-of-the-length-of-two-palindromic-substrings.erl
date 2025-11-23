-module(solution).
-export([max_product/1]).

max_product(S) ->
    N = erlang:length(S),
    Max = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                I < J ->
                    A = substring(S, I, J),
                    B = substring(S, J, N-1),
                    case is_palindrome(A) andalso is_palindrome(B) of
                        true -> max(length(A)*length(B), Acc2);
                        false -> Acc2
                    end;
                true -> Acc2
            end
        end, Acc, lists:seq(I+1, N-1))
    end, Max, lists:seq(0, N-1)).

substring(S, Start, End) ->
    erlang:binary_part(S, Start, End - Start + 1).

is_palindrome(S) ->
    S == erlang:list_to_binary(lists:reverse(erlang:binary_to_list(S))).