-module(dice_roll_simulation).
-export([die_simulator/2]).

die_simulator(n, rollMax) ->
    Mod = 1000000007,
    die_simulator_helper(n, rollMax, 0, [], dict:new(), Mod).

die_simulator_helper(0, _, _, _, _, _) ->
    1;
die_simulator_helper(N, RollMax, LastRoll, Acc, Memo, Mod) ->
    Key = {N, LastRoll, Acc},
    case dict:find(Key, Memo) of
        {ok, Value} ->
            Value;
        error ->
            Result = die_simulator_calculate(N, RollMax, LastRoll, Acc, Memo, Mod),
            Memo2 = dict:store(Key, Result, Memo),
            Result
    end.

die_simulator_calculate(N, RollMax, LastRoll, Acc, Memo, Mod) ->
    lists:foldl(
        fun(I, Sum) ->
            if I == LastRoll then
                if Acc + 1 =< RollMax[I - 1] then
                    (Sum + die_simulator_helper(N - 1, RollMax, I, Acc + 1, Memo, Mod)) rem Mod
                else
                    Sum
                end
            else
                (Sum + die_simulator_helper(N - 1, RollMax, I, 1, Memo, Mod)) rem Mod
            end
        end,
        0,
        lists:seq(1, 6)
    ).