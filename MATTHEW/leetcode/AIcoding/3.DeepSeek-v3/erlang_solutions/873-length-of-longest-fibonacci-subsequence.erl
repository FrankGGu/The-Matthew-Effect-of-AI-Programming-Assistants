-spec len_longest_fib_subseq(Arr :: [integer()]) -> integer().
len_longest_fib_subseq(Arr) ->
    N = length(Arr),
    S = sets:from_list(Arr),
    Max = 0,
    find_max(Arr, S, N, Max).

find_max(Arr, S, N, Max) ->
    find_max(Arr, S, N, Max, 0).

find_max(_, _, N, Max, I) when I >= N - 1 ->
    Max;
find_max(Arr, S, N, Max, I) ->
    JStart = I + 1,
    NewMax = find_j_max(Arr, S, N, Max, I, JStart),
    find_max(Arr, S, N, NewMax, I + 1).

find_j_max(_, _, N, Max, _, J) when J >= N ->
    Max;
find_j_max(Arr, S, N, Max, I, J) ->
    X = lists:nth(I + 1, Arr),
    Y = lists:nth(J + 1, Arr),
    Len = 2,
    NewMax = check_fib(S, X, Y, Len, Max),
    find_j_max(Arr, S, N, NewMax, I, J + 1).

check_fib(S, X, Y, Len, Max) ->
    Z = X + Y,
    case sets:is_element(Z, S) of
        true ->
            NewLen = Len + 1,
            NewMax = erlang:max(NewLen, Max),
            check_fib(S, Y, Z, NewLen, NewMax);
        false ->
            erlang:max(Len, Max)
    end.