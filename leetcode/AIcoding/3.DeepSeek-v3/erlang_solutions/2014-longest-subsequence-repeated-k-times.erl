-module(solution).
-export([longest_subsequence_repeated_k/2]).

longest_subsequence_repeated_k(S, K) ->
    N = length(S),
    MaxLen = N div K,
    find_max_subsequence(S, K, MaxLen, []).

find_max_subsequence(_, _, 0, Acc) ->
    Acc;
find_max_subsequence(S, K, Len, Acc) ->
    case generate_subsequences(S, Len) of
        [] ->
            find_max_subsequence(S, K, Len - 1, Acc);
        Subsequences ->
            case lists:filter(fun(Sub) -> is_repeated_k_times(S, Sub, K) end, Subsequences) of
                [] ->
                    find_max_subsequence(S, K, Len - 1, Acc);
                [H | _] ->
                    case compare_lex(H, Acc) of
                        true -> H;
                        false -> Acc
                    end
            end
    end.

generate_subsequences(S, Len) ->
    case Len of
        0 -> [[]];
        _ ->
            case S of
                [] -> [];
                [H | T] ->
                    WithH = [ [H | Sub] || Sub <- generate_subsequences(T, Len - 1)],
                    WithoutH = generate_subsequences(T, Len),
                    lists:usort(WithH ++ WithoutH)
            end
    end.

is_repeated_k_times(S, Sub, K) ->
    is_repeated_k_times(S, Sub, K, 0, 0).

is_repeated_k_times(_, _, K, Count, _) when Count >= K ->
    true;
is_repeated_k_times([], _, _, _, _) ->
    false;
is_repeated_k_times([H | T], [H | SubT], K, Count, Pos) ->
    is_repeated_k_times(T, SubT, K, Count, Pos + 1);
is_repeated_k_times([_ | T], Sub, K, Count, Pos) ->
    case Sub of
        [] -> is_repeated_k_times(T, Sub, K, Count + 1, 0);
        _ -> is_repeated_k_times(T, Sub, K, Count, Pos)
    end.

compare_lex(A, B) ->
    case {A, B} of
        {[], _} -> false;
        {_, []} -> true;
        {[HA | TA], [HB | TB]} ->
            if
                HA > HB -> true;
                HA < HB -> false;
                true -> compare_lex(TA, TB)
            end
    end.