-module(solution).
-export([can_make_subsequence/2]).

can_make_subsequence(S, T) ->
    can_make_subsequence(S, T, 0).

can_make_subsequence([], _) -> true;
can_make_subsequence(_, []) -> false;
can_make_subsequence([H1 | T1], [H2 | T2]) ->
    if
        (H1 + 26 - H2) rem 26 =< 0 ->
            can_make_subsequence(T1, T2);
        true ->
            false
    end.