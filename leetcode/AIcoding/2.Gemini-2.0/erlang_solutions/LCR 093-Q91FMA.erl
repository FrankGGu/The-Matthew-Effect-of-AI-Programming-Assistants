-module(longest_fib_subsequence).
-export([lenLongestFibSubseq/1]).

lenLongestFibSubseq(A) ->
    Set = sets:from_list(A),
    Len = length(A),
    MaxLen = 0,
    lists:foreach(fun (I) ->
                          lists:foreach(fun (J) ->
                                               case I < J of
                                                   true ->
                                                       Len1 = fib(A, Set, I, J, 2);
                                                       MaxLen1 = max(MaxLen, Len1),
                                                       MaxLen = MaxLen1;
                                                   false ->
                                                       ignore
                                               end
                                           end, lists:nthtail(1, A))
                      end, A),
    if
        MaxLen > 2 -> MaxLen;
        true -> 0
    end.

fib(A, Set, X, Y, Len) ->
    Z = X + Y,
    case sets:is_element(Z, Set) of
        true ->
            fib(A, Set, Y, Z, Len + 1);
        false ->
            Len
    end.