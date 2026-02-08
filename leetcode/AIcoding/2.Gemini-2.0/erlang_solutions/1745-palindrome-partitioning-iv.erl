-module(palindrome_partitioning_iv).
-export([can_partition/1]).

can_partition(S) ->
    N = length(S),
    P = palindromes(S),
    can_partition(S, 0, 3, P).

can_partition(_, _, 0, _) ->
    true;
can_partition(S, Start, K, P) ->
    N = length(S),
    Len = length(S),
    lists:any(fun(End) ->
                      (End >= Start andalso lists:member({Start + 1, End + 1}, P)) andalso
                          can_partition(S, End + 1, K - 1, P)
              end, lists:seq(Start, N - 1)).

palindromes(S) ->
    N = length(S),
    palindromes(S, N).

palindromes(S, N) ->
    lists:foldl(fun(I, Acc) ->
                        lists:foldl(fun(J, Acc2) ->
                                            case is_palindrome(S, I, J) of
                                                true ->
                                                    [{I,J} | Acc2];
                                                false ->
                                                    Acc2
                                            end
                                    end, Acc, lists:seq(I, N))
                end, [], lists:seq(1, N)).

is_palindrome(S, I, J) ->
    is_palindrome(S, I, J, []).

is_palindrome(S, I, J, Acc) ->
    if
        I > J ->
            true;
        true ->
            CharI = lists:nth(I, string:characters(S, utf8)),
            CharJ = lists:nth(J, string:characters(S, utf8)),
            if
                CharI =/= CharJ ->
                    false;
                true ->
                    is_palindrome(S, I + 1, J - 1, Acc)
            end
    end.