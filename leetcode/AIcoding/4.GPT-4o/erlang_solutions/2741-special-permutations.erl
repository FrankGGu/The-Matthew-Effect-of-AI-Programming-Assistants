-module(solution).
-export([special_permutations/1]).

special_permutations(N) ->
    lists:sum(lists:map(fun(X) -> count_permutations(X, N) end, generate_permutations(N))).

generate_permutations(N) ->
    lists:foldl(fun(X, Acc) -> lists:map(fun(Y) -> [X | Y] end, Acc) end, [[]], lists:seq(1, N)).

count_permutations(Perm, N) ->
    case lists:foldl(fun(X, {Count, Last}) ->
        if
            Count rem 2 =:= 0 orelse X = Last ->
                {Count + 1, X}
            ; 
                {Count, X}
        end
    end, {0, 0}, Perm) of
        {Count, _} -> if Count rem 2 =:= 0 -> 1; true -> 0 end
    end.