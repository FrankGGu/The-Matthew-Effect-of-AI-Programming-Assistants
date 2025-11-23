-module(maximum_deletions).
-export([maximum_deletions/1]).

maximum_deletions(Str) ->
    N = string:length(Str),
    S = string:to_lower(Str),
    MaxDel = maximum_deletions_helper(S, [], N),
    MaxDel.

maximum_deletions_helper([], Acc, _) -> 
    length(Acc);
maximum_deletions_helper([H | T], Acc, N) ->
    case lists:member(H, Acc) of
        true -> maximum_deletions_helper(T, lists:delete(H, Acc), N);
        false -> maximum_deletions_helper(T, [H | Acc], N)
    end.