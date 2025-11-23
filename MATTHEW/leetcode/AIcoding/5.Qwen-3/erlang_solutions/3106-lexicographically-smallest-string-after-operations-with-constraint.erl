-module(lexicographically_smallest_string_after_operations_with_constraint).
-export([lexicographically_smallest_string/2]).

lexicographically_smallest_string(S, K) ->
    List = string:to_list(S),
    N = length(List),
    lex_smallest(List, K, N).

lex_smallest(List, 0, _) ->
    string:from_list(List);
lex_smallest(List, K, N) ->
    MinChar = lists:min(List),
    Pos = lists:foldl(fun(I, Acc) -> 
        if lists:nth(I+1, List) == MinChar -> I;
           true -> Acc
        end
    end, N, lists:seq(0, N-1)),
    if Pos + 1 > K -> 
        lex_smallest(List, K, N);
       true ->
        NewList = lists:sublist(List, Pos) ++ [min_char()] ++ lists:sublist(List, Pos+1, N - Pos - 1),
        lex_smallest(NewList, K - (Pos + 1), N)
    end.

min_char() ->
    $a.