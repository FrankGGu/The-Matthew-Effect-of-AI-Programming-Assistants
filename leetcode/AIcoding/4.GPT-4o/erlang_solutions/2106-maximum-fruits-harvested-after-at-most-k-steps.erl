-module(solution).
-export([max_fruits/2]).

max_fruits(Fruits, K) ->
    max_fruits(Fruits, K, 0, 0, 0).

max_fruits(_, 0, _, Max, _) -> Max;
max_fruits(Fruits, K, Index, Max, CurrentSum) ->
    case lists:split_at(Index, Fruits) of
        {Left, []} -> Max;
        {Left, [H | T]} ->
            NewSum = CurrentSum + H,
            NewMax = max(NewSum, Max),
            if 
                K >= 1 -> 
                    max_fruits(Fruits, K - 1, Index + 1, NewMax, NewSum);
                true -> 
                    NewMax
            end
    end.