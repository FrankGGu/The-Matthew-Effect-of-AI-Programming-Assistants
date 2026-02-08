-module(jump_game_v).
-export([jump/1]).

jump(Numbers) ->
    N = length(Numbers),
    DP = array:new(N, {default, 0}),
    jump_helper(Numbers, DP, 0, N).

jump_helper(_, _, Index, N) when Index >= N ->
    0;
jump_helper(Numbers, DP, Index, N) ->
    case array:get(Index, DP) of
        0 ->
            Max = max(
                jump_helper(Numbers, DP, Index + 1, N),
                jump_helper(Numbers, DP, Index - 1, N)
            ),
            Value = array:get(Index, Numbers),
            NewDP = array:set(Index, Max + 1, DP),
            jump_helper(Numbers, NewDP, Index + 1, N);
        Val ->
            Val
    end.