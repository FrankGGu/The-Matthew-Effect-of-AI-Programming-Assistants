-spec longest_common_subsequence(Text1 :: unicode:unicode_binary(), Text2 :: unicode:unicode_binary()) -> integer().
longest_common_subsequence(Text1, Text2) ->
    S1 = unicode:characters_to_list(Text1),
    S2 = unicode:characters_to_list(Text2),
    M = length(S1),
    N = length(S2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    DP1 = lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            case I > 0 andalso J > 0 andalso lists:nth(I, S1) =:= lists:nth(J, S2) of
                true ->
                    Val = lists:nth(I, lists:nth(J - 1, AccJ)) + 1,
                    set_val(I, J, Val, AccJ);
                false ->
                    Val1 = lists:nth(I, lists:nth(J - 1, AccJ))),
                    Val2 = lists:nth(I - 1, lists:nth(J, AccJ))),
                    set_val(I, J, max(Val1, Val2), AccJ)
            end
        end, AccI, lists:seq(1, N))
    end, DP, lists:seq(1, M)),
    lists:nth(M, lists:nth(N, DP1)).

set_val(I, J, Val, DP) ->
    Row = lists:nth(I, DP),
    NewRow = setnth(J, Val, Row),
    setnth(I, NewRow, DP).

setnth(1, Val, [_|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N-1, Val, T)].