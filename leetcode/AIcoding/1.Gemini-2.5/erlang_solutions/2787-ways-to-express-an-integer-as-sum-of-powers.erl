-module(solution).
-export([ways_to_express_an_integer_as_sum_of_powers/2]).

ways_to_express_an_integer_as_sum_of_powers(N, X) ->
    MaxBase = floor(math:pow(N, 1.0/X)),
    {Result, _Memo} = solve(N, 1, X, MaxBase, #{}),
    Result.

solve(Target, CurrentBase, X, MaxBase, Memo) ->
    Key = {Target, CurrentBase},
    case maps:find(Key, Memo) of
        {ok, Value} -> {Value, Memo};
        _ ->
            Result =
                if Target == 0 -> 1;
                   Target < 0 -> 0;
                   CurrentBase > MaxBase -> 0
                else
                    Power = round(math:pow(CurrentBase, X));
                    if Power > Target ->
                        {Res, NewMemo} = solve(Target, CurrentBase + 1, X, MaxBase, Memo),
                        Res
                    else
                        Mod = 1000000007,
                        {Res1, Memo1} = solve(Target, CurrentBase + 1, X, MaxBase, Memo),
                        {Res2, Memo2} = solve(Target - Power, CurrentBase + 1, X, MaxBase, Memo1),
                        (Res1 + Res2) rem Mod
                    end
                end,
            {Result, maps:put(Key, Result, Memo)}
    end.