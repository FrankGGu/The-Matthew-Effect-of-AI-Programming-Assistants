-module(solution).
-compile([export_all]).

-spec is_subsequence(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
is_subsequence(S, T) -> is_subsequence(S, T, 0).

is_subsequence(_, [], _) -> false;
is_subsequence([], _, _) -> true;
is_subsequence([SHead | STail], [THead | TTail], Index) when SHead =:= THead -> 
    is_subsequence(STail, TTail, Index + 1);
is_subsequence(S, [THead | TTail], Index) -> 
    is_subsequence(S, TTail, Index).
