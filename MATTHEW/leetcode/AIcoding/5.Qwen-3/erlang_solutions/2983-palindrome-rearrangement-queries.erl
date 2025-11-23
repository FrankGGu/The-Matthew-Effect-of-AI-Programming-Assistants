-module(palindrome_rearrangement_queries).
-export([canMakePalindromeQueries/2]).

canMakePalindromeQueries(S, Queries) ->
    N = length(S),
    Count = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, S),
    Result = [],
    lists:foldl(fun(Query, Acc) -> 
        {Index, Length} = Query,
        SubStr = lists:sublist(S, Index + 1, Length),
        SubCount = lists:foldl(fun(Char, Acc2) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc2) end, #{}, SubStr),
        CombinedCount = maps:merge_with(fun(_, V1, V2) -> V1 + V2 end, Count, SubCount),
        OddCount = maps:fold(fun(_, V, Acc3) -> if V rem 2 /= 0 -> Acc3 + 1; true -> Acc3 end end, 0, CombinedCount),
        case (N - Length) rem 2 of
            0 when OddCount =< 1 -> [true | Acc];
            1 when OddCount =< 2 -> [true | Acc];
            _ -> [false | Acc]
        end
    end, Result, Queries).

getCharCount(Str) ->
    lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, Str).