-module(solution).
-export([can_make_pali_queries/2]).

can_make_pali_queries(S, Queries) ->
    N = length(S),
    Prefix = lists:foldl(fun(Char, Acc) ->
        Last = case Acc of [] -> [0]; _ -> [hd(Acc)] end,
        [Char bxor hd(Last) | Acc]
    end, [], S),
    PrefixList = lists:reverse(Prefix),
    lists:map(fun({L, R, K}) ->
        Len = R - L + 1,
        if
            Len rem 2 == 0 -> 
                Count = count_ones(lists:nth(R + 1, PrefixList) bxor lists:nth(L + 1, PrefixList)),
                Count div 2 =< K;
            true -> 
                Count = count_ones(lists:nth(R + 1, PrefixList) bxor lists:nth(L + 1, PrefixList)),
                (Count - 1) div 2 =< K
        end
    end, Queries).

count_ones(X) ->
    count_ones(X, 0).

count_ones(0, Acc) -> Acc;
count_ones(X, Acc) ->
    count_ones(X bsr 1, Acc + (X band 1)).