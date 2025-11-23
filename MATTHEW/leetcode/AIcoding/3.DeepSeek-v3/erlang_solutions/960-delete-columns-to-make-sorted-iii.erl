-spec min_deletion_size(Strs :: [unicode:unicode_binary()]) -> integer().
min_deletion_size(Strs) ->
    case Strs of
        [] -> 0;
        _ ->
            M = length(Strs),
            N = byte_size(hd(Strs)),
            DP = lists:duplicate(N, 1),
            MaxLen = lists:max(lists:foldl(fun(I, Acc) ->
                lists:foldl(fun(J, InnerAcc) ->
                    case is_sorted(Strs, I, J) of
                        true ->
                            Max = max(lists:nth(J + 1, InnerAcc), lists:nth(I + 1, DP) + 1),
                            setnth(J + 1, InnerAcc, Max);
                        false ->
                            InnerAcc
                    end
                end, Acc, lists:seq(0, I - 1))
            end, DP, lists:seq(1, N - 1))),
            N - MaxLen
    end.

is_sorted(Strs, I, J) ->
    lists:all(fun(Str) ->
        binary:at(Str, J) =< binary:at(Str, I)
    end, Strs).

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].