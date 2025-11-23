-module(solution).
-export([predict_the_winner/1]).

%% Use dynamic programming to solve this problem.
-spec predict_the_winner([integer()]) -> boolean().
predict_the_winner(Nums) ->
    Length = length(Nums),
    Memo = lists:duplicate(Length, lists:duplicate(Length, undefined)),
    case dp(Nums, 0, Length - 1, Memo) >= 0 of
        true -> true;
        false -> false
    end.

%% Dynamic programming helper function.
-spec dp([integer()], integer(), integer(), [[any()]]) -> integer().
dp(Nums, Left, Right, Memo) when Left == Right ->
    hd(lists:nth(Left + 1, Nums));
dp(Nums, Left, Right, Memo) ->
    case lists:nth(Left + 1, Memo) of
        undefined -> 
            First = lists:nth(Left + 1, Nums),
            Second = dp(Nums, Left + 1, Right, Memo),
            Result1 = First - Second,
            case lists:nth(Right + 1, Memo) of
                undefined ->
                    Third = lists:nth(Right + 1, Nums),
                    Fourth = dp(Nums, Left, Right - 1, Memo),
                    Result2 = Third - Fourth,
                    Max = max(Result1, Result2),
                    put(Memo, Left, Right, Max);
                _ -> 
                    Max = max(Result1, Result2),
                    put(Memo, Left, Right, Max)
            end;
        _ ->
            undefined
    end.
            
%% Helper function to update memoization
-spec put([[any()]], integer(), integer(), integer()) -> [[any()]].
put(Memo, Left, Right, Value) ->
    lists:sublist(Memo, 1, Left) ++ [lists:sublist(Memo, Right+1)] ++ [Value] ++ lists:sublist(Memo, Right + 2, length(Memo)).
