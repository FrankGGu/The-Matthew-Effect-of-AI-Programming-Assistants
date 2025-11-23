-module(stamping_the_sequence).
-export([possible_to_stamp/2]).

possible_to_stamp(S, T) ->
    N = length(S),
    M = length(T),
    if
        M > N -> false;
        true ->
            T1 = lists:reverse(T),
            S1 = lists:reverse(S),
            Possible = possible_to_stamp_helper(S1, T1, 0, 0, N - 1, M - 1, []),
            case Possible of
                {true, _} -> true;
                _ -> false
            end
    end.

possible_to_stamp_helper(_, _, _, _, _, -1, _) -> {true, []};
possible_to_stamp_helper(S, T, i, j, si, ti, Acc) ->
    if
        j >= length(T) ->
            possible_to_stamp_helper(S, T, i, 0, si, ti, Acc);
        true ->
            case lists:nth(j + 1, T) of
                lists:nth(i + 1, S) ->
                    possible_to_stamp_helper(S, T, i + 1, j + 1, si, ti, [i | Acc]);
                _ ->
                    if
                        i < length(S) ->
                            possible_to_stamp_helper(S, T, i + 1, j, si, ti, Acc);
                        true ->
                            {false, Acc}
                    end
            end
    end.