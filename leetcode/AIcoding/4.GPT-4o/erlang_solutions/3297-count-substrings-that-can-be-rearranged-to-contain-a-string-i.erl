-module(solution).
-export([count_substrings/2]).

count_substrings(S, T) ->
    count_substrings(S, T, length(T), length(S), 0).

count_substrings(_, [], _, _, Count) ->
    Count;
count_substrings(S, T, T_len, S_len, Count) when S_len < T_len ->
    Count;
count_substrings(S, T, T_len, S_len, Count) ->
    case lists:sublist(S, 0, T_len) of
        Sub when can_rearrange(Sub, T) ->
            count_substrings(tl(S), T, T_len, S_len - 1, Count + 1);
        _ ->
            count_substrings(tl(S), T, T_len, S_len - 1, Count)
    end.

can_rearrange(Sub, T) ->
    counts(Sub) =:= counts(T).

counts(Str) ->
    lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, maps:new(), Str).