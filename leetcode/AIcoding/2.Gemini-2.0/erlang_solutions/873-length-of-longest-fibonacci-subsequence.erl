-module(longest_fibonacci).
-export([lenLongestFibSubseq/1]).

lenLongestFibSubseq(A) ->
    Set = sets:from_list(A),
    N = length(A),
    lenLongestFibSubseq(A, Set, N, 0).

lenLongestFibSubseq(A, Set, N, Max) ->
    lenLongestFibSubseq(A, Set, N, 0, 0, Max).

lenLongestFibSubseq(A, Set, N, I, J, Max) ->
    if
        I >= N ->
            Max;
        true ->
            lenLongestFibSubseq(A, Set, N, I + 1, J, lenLongestFibSubseq2(A, Set, N, A[I + 1], A, I + 2, Max))
    end.

lenLongestFibSubseq2(A, Set, N, First, A2, J, Max) ->
    if
        J > length(A2) ->
            Max;
        true ->
            Second = lists:nth(J, A2),
            lenLongestFibSubseq2(A, Set, N, First, A2, J + 1, max(Max, fibonacciLength(First, Second, Set) ))
    end.

fibonacciLength(First, Second, Set) ->
    fibonacciLength(First, Second, Set, 2).

fibonacciLength(First, Second, Set, Length) ->
    Next = First + Second,
    case sets:is_element(Next, Set) of
        true ->
            fibonacciLength(Second, Next, Set, Length + 1);
        false ->
            if
                Length > 2 ->
                    Length;
                true ->
                    0
            end
    end.