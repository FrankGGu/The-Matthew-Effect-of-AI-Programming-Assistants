-module(solution).
-export([min_deletions/1]).

min_deletions(Str) ->
    Frequencies = lists:foldl(fun (C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, fun() -> 1 end, Acc) end, #{}, string:to_list(Str)),
    UniqueFrequencies = maps:values(Frequencies),
    min_deletions_helper(UniqueFrequencies, []).

min_deletions_helper([], _) -> 
    0;
min_deletions_helper([H | T], Seen) ->
    if
        lists:member(H, Seen) ->
            NewH = max(0, H - 1),
            min_deletions_helper(T, [NewH | Seen]) + (H - NewH);
        true ->
            min_deletions_helper(T, [H | Seen])
    end.