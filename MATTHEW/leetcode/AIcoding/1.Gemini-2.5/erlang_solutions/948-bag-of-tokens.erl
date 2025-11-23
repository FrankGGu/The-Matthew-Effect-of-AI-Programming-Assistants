-module(solution).
-export([bag_of_tokens/2]).

bag_of_tokens(Tokens, Power) ->
    SortedTokens = lists:sort(Tokens),
    solve(SortedTokens, lists:reverse(SortedTokens), Power, 0, 0).

solve(LeftTokens, RightTokens, CurrentPower, CurrentScore, MaxScore) ->
    case {LeftTokens, RightTokens} of
        {[], _} -> MaxScore;
        {_, []} -> MaxScore;
        {[L], [R]} when L == R ->
            if
                CurrentPower >= L -> max(MaxScore, CurrentScore + 1);
                true -> MaxScore
            end;
        _ ->
            SmallestToken = hd(LeftTokens),
            LargestToken = hd(RightTokens),
            if
                CurrentPower >= SmallestToken ->
                    NewPower = CurrentPower - SmallestToken,
                    NewScore = CurrentScore + 1,
                    NewMaxScore = max(MaxScore, NewScore),
                    solve(tl(LeftTokens), RightTokens, NewPower, NewScore, NewMaxScore);
                CurrentScore >= 1 ->
                    NewPower = CurrentPower + LargestToken,
                    NewScore = CurrentScore - 1,
                    solve(LeftTokens, tl(RightTokens), NewPower, NewScore, MaxScore);
                true -> MaxScore
            end
    end.