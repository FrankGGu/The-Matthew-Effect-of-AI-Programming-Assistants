-module(solution).
-export([minimum_score/2]).

minimum_score(S, T) ->
    N = length(S),
    M = length(T),
    Pre = preprocess(S, T),
    Suff = lists:reverse(preprocess(lists:reverse(S), lists:reverse(T))),
    binary_search(Pre, Suff, N, M).

preprocess(S, T) ->
    preprocess(S, T, 0, []).

preprocess([], _, I, Acc) ->
    lists:reverse(Acc);
preprocess([H|S], [H|T], I, Acc) ->
    preprocess(S, T, I + 1, [I + 1|Acc]);
preprocess([_|S], T, I, Acc) ->
    preprocess(S, T, I, [I|Acc]).

binary_search(Pre, Suff, N, M) ->
    binary_search(Pre, Suff, N, M, 0, N - M).

binary_search(_, _, _, _, Low, High) when Low >= High ->
    Low;
binary_search(Pre, Suff, N, M, Low, High) ->
    Mid = (Low + High) div 2,
    case is_possible(Pre, Suff, N, M, Mid) of
        true -> binary_search(Pre, Suff, N, M, Low, Mid);
        false -> binary_search(Pre, Suff, N, M, Mid + 1, High)
    end.

is_possible(Pre, Suff, N, M, K) ->
    case find_valid(Pre, Suff, N, M, K) of
        {true, _} -> true;
        false -> false
    end.

find_valid(Pre, Suff, N, M, K) ->
    find_valid(Pre, Suff, N, M, K, 0, M - K).

find_valid(Pre, Suff, N, M, K, I, J) when I + J =< M ->
    case (I =:= 0 orelse lists:nth(I, Pre) =/= -1) andalso
         (J =:= 0 orelse lists:nth(M - J + 1, Suff) =/= -1) andalso
         (I =:= 0 orelse J =:= 0 orelse lists:nth(I, Pre) < lists:nth(M - J + 1, Suff)) of
        true -> {true, ok};
        false -> find_valid(Pre, Suff, N, M, K, I + 1, J - 1)
    end;
find_valid(_, _, _, _, _, _, _) ->
    false.