-module(solution).
-export([count_special_subsequences/1]).

count_special_subsequences(S) ->
    N = length(S),
    count_special_subs(S, N, 0, 0, 0, 0).

count_special_subs(_, 0, _, _, Count, _) -> Count;
count_special_subs(S, N, I, J, Count, Mask) ->
    NewCount = case lists:nth(I+1, S) of
        $0 -> Count + (if Mask band 1 > 0 -> 1; true -> 0 end);
        $1 -> Count + (if Mask band 2 > 0 -> 1; true -> 0 end);
        $2 -> Count
    end,
    count_special_subs(S, N, I + 1, J + 1, NewCount, Mask bsr 1).

count_special_subs(S, N, I, J, Count, Mask) when I < N ->
    case lists:nth(I+1, S) of
        $0 -> count_special_subs(S, N, I + 1, J, Count, (Mask band 1) bsl 1);
        $1 -> count_special_subs(S, N, I + 1, J, Count, (Mask band 2) bsl 1);
        $2 -> count_special_subs(S, N, I + 1, J, Count, Mask bsl 1)
    end;
count_special_subs(_, N, I, _, Count, _) when I >= N -> Count.