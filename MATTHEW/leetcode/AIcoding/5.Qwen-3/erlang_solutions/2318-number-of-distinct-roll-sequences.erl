-module(solution).
-export([num_rolls_to_target/2]).

num_rolls_to_target(Target, Mod) ->
    dp(Target, Mod, 1, 0, 1, #{}).

dp(_, _, _, _, _, Acc) when maps:size(Acc) == 6 ->
    maps:fold(fun(_, V, Sum) -> (Sum + V) rem Mod end, 0, Acc);
dp(Target, Mod, Step, Pos, Count, Acc) ->
    case maps:is_key(Pos, Acc) of
        true ->
            NewAcc = maps:update(Pos, (maps:get(Pos, Acc) + Count) rem Mod, Acc),
            dp(Target, Mod, Step + 1, 0, 1, NewAcc);
        false ->
            NewAcc = maps:put(Pos, Count, Acc),
            dp(Target, Mod, Step, Pos + 1, 1, NewAcc)
    end.