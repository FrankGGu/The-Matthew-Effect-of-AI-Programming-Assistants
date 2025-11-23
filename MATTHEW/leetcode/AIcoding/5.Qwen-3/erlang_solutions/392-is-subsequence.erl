-module(solution).
-export([is_subsequence/2]).

is_subsequence(_, []) -> true;
is_subsequence([], _) -> false;
is_subsequence([H|T1], [H|T2]) -> is_subsequence(T1, T2);
is_subsequence([H|T1], [_|T2]) -> is_subsequence([H|T1], T2).