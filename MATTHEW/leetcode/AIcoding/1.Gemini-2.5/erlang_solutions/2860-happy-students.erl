-module(solution).
-export([happy_students/1]).

happy_students(Nums) ->
    N = length(Nums),
    SortedNums = lists:sort(Nums),

    % k=0 is always a valid choice (no students chosen, all unchosen students are happy if their skill >= 0, which is always true)
    Count = 1, 

    % Iterate k from 1 to N
    happy_students_loop(1, N, SortedNums, Count).

happy_students_loop(K, N, SortedNums, Acc) when K =< N ->
    % Condition for chosen students: the K-th smallest skill (0-indexed: SortedNums[K-1]) must be < K
    % In Erlang lists:nth is 1-indexed, so SortedNums[K-1] corresponds to lists:nth(K, SortedNums)
    ChosenHappy = (lists:nth(K, SortedNums) < K),

    % Condition for unchosen students: the (K+1)-th smallest skill (0-indexed: SortedNums[K]) must be >= K
    % In Erlang lists:nth is 1-indexed, so SortedNums[K] corresponds to lists:nth(K+1, SortedNums)
    UnchosenHappy = 
        if 
            K < N -> % There are unchosen students, check the condition
                (lists:nth(K+1, SortedNums) >= K);
            true -> % K = N, all students are chosen, so there are no unchosen students. This condition is vacuously true.
                true
        end,

    NewAcc = 
        if 
            ChosenHappy and UnchosenHappy -> Acc + 1;
            true -> Acc
        end,

    happy_students_loop(K + 1, N, SortedNums, NewAcc);

happy_students_loop(_K, _N, _SortedNums, Acc) ->
    Acc.