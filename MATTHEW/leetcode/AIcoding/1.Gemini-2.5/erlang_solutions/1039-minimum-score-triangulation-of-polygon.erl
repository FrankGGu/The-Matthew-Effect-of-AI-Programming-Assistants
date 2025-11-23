-module(solution).
-export([minScoreTriangulation/1]).

minScoreTriangulation(Values) ->
    N = length(Values),
    V_tuple = list_to_tuple(Values),
    {MinScore, _FinalMemo} = dp(0, N - 1, V_tuple, maps:new()),
    MinScore.

dp(I, J, _V_tuple, Memo) when J - I < 2 ->
    {0, Memo};
dp(I, J, V_tuple, Memo) ->
    case maps:find({I, J}, Memo) of
        {ok, Score} ->
            {Score, Memo};
        _ ->
            % A sufficiently large number to represent infinity for minimum calculation
            LargeNum = 1_000_000_000_000_000, 

            % Use foldl to iterate through possible 'k' values and accumulate the minimum score and updated memo
            {MinScore, NewMemo} = lists:foldl(
                fun(K, {AccMin, AccMemo}) ->
                    V_I = element(I + 1, V_tuple),
                    V_K = element(K + 1, V_tuple),
                    V_J = element(J + 1, V_tuple),

                    Product = V_I * V_K * V_J,

                    % Recursively solve subproblems and pass the updated memo
                    {ScoreIK, Memo1} = dp(I, K, V_tuple, AccMemo),
                    {ScoreKJ, Memo2} = dp(K, J, V_tuple, Memo1),

                    CurrentScore = Product + ScoreIK + ScoreKJ,
                    {min(AccMin, CurrentScore), Memo2}
                end,
                {LargeNum, Memo}, % Initial accumulator: large score and current memo
                lists:seq(I + 1, J - 1) % Iterate k from I+1 to J-1
            ),

            % Store the calculated minimum score in the memo
            FinalMemo = maps:put({I, J}, MinScore, NewMemo),
            {MinScore, FinalMemo}
    end.