-solve(Questions) ->
    solve(Questions, 0, #{}).

solve([], _Index, Memo) ->
    0;
solve([{Points, Brainpower} | Rest], Index, Memo) ->
    case maps:find(Index, Memo) of
        {ok, Cached} ->
            Cached;
        error ->
            Take = Points + solve(Rest, Index + Brainpower + 1, Memo),
            Skip = solve(Rest, Index + 1, Memo),
            Max = max(Take, Skip),
            Memo1 = maps:put(Index, Max, Memo),
            Max
    end.