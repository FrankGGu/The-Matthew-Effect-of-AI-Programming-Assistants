-spec delete_and_earn(Nums :: [integer()]) -> integer().
delete_and_earn(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            Freq = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + X end, X, Acc) end, #{}, Nums),
            Keys = lists:sort(maps:keys(Freq)),
            dp(Keys, Freq, #{})
    end.

dp([], _, Memo) -> 0;
dp([X | Rest], Freq, Memo) ->
    case maps:is_key(X, Memo) of
        true -> maps:get(X, Memo);
        false ->
            Earn = maps:get(X, Freq),
            case Rest of
                [Y | _] when Y == X + 1 ->
                    Take = Earn + dp(tl(Rest), Freq, Memo),
                    Skip = dp(Rest, Freq, Memo),
                    Max = max(Take, Skip),
                    NewMemo = maps:put(X, Max, Memo),
                    Max;
                _ ->
                    Take = Earn + dp(Rest, Freq, Memo),
                    NewMemo = maps:put(X, Take, Memo),
                    Take
            end
    end.