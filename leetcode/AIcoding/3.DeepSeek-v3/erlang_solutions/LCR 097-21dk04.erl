-spec num_distinct(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
num_distinct(S, T) ->
    M = byte_size(S),
    N = byte_size(T),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    DP1 = init_dp(DP, M),
    DP2 = fill_dp(DP1, S, T, M, N),
    get_result(DP2, M, N).

init_dp(DP, M) ->
    lists:foldl(fun(I, Acc) -> 
                    set(Acc, I, 0, 1) 
                end, DP, lists:seq(0, M)).

fill_dp(DP, S, T, M, N) ->
    lists:foldl(fun(J, AccJ) ->
        lists:foldl(fun(I, AccI) ->
            case I >= 1 andalso J >= 1 of
                true ->
                    SChar = binary:at(S, I - 1),
                    TChar = binary:at(T, J - 1),
                    case SChar =:= TChar of
                        true ->
                            Val = get(AccI, I - 1, J - 1) + get(AccI, I - 1, J),
                            set(AccI, I, J, Val);
                        false ->
                            Val = get(AccI, I - 1, J),
                            set(AccI, I, J, Val)
                    end;
                false ->
                    AccI
            end
        end, AccJ, lists:seq(1, M))
    end, DP, lists:seq(1, N)).

get(DP, I, J) ->
    lists:nth(J + 1, lists:nth(I + 1, DP)).

set(DP, I, J, Val) ->
    Row = lists:nth(I + 1, DP),
    NewRow = setnth(J + 1, Val, Row),
    setnth(I + 1, NewRow, DP).

setnth(1, Val, [_|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N - 1, Val, T)].

get_result(DP, M, N) ->
    get(DP, M, N).