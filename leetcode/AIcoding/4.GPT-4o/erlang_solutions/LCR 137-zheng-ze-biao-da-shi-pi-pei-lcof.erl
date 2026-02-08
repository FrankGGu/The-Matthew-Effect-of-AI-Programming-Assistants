-module(solution).
-export([fuzzy_search/2]).

fuzzy_search(A, B) ->
    fuzzy_search_helper(A, B, 0).

fuzzy_search_helper([], _, _) -> 
    true;
fuzzy_search_helper(_, [], _) -> 
    false;
fuzzy_search_helper([H1 | T1], [H2 | T2], Index) when H1 =:= H2 -> 
    fuzzy_search_helper(T1, T2, Index + 1);
fuzzy_search_helper([H1 | T1], [H2 | T2], Index) when H1 =/= H2 -> 
    fuzzy_search_helper(T1, T2, Index + 1);