-module(solution).
-export([count_subarrays/2]).

count_subarrays(Pattern, A) ->
    N = length(A),
    M = length(Pattern),
    Count = 0,
    lists:foldl(fun(Idx, Acc) ->
        if 
            Idx + M =< N andalso match_pattern(lists:sublist(A, Idx, M), Pattern) -> 
                Acc + 1;
            true -> 
                Acc
        end
    end, Count, lists:seq(0, N - M)).

match_pattern([], []) -> true;
match_pattern([H1 | T1], [H2 | T2]) -> 
    (H1 == H2 orelse H2 == 0) andalso match_pattern(T1, T2);
match_pattern(_, _) -> false.