-module(solution).
-export([count_k_constrained_substrings/1]).

count_k_constrained_substrings(S) ->
    N = length(S),
    Count = 0,
    count_k_constrained_substrings(S, N, 0, 0, Count).

count_k_constrained_substrings(_, _, _, _, Count) when Count >= 100000 -> Count;
count_k_constrained_substrings(S, N, I, J, Count) when I < N ->
    case J < N of
        true ->
            case (lists:nth(I+1, S) == lists:nth(J+1, S)) of
                true ->
                    count_k_constrained_substrings(S, N, I, J+1, Count + 1);
                false ->
                    count_k_constrained_substrings(S, N, I+1, I+1, Count)
            end;
        false ->
            count_k_constrained_substrings(S, N, I+1, I+1, Count)
    end;
count_k_constrained_substrings(_, _, _, _, Count) -> Count.