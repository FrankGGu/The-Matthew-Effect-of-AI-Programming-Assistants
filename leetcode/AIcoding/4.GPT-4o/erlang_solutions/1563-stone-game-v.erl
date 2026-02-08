-module(solution).
-export([stone_game_v/1]).

stone_game_v(Piles) ->
    N = length(Piles),
    DP = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    stone_game_v_helper(Piles, 1, N, DP).

stone_game_v_helper(_, Start, End, DP) when Start > End ->
    0;
stone_game_v_helper(Piles, Start, End, DP) ->
    if
        DP(Start, End) /= 0 ->
            DP(Start, End);
        true ->
            Sum = lists:sum(lists:sublist(Piles, Start - 1, End - Start + 1)),
            MaxScore = -1,
            lists:foreach(fun(X) ->
                if
                    X < Start orelse X > End ->
                        ok;
                    true ->
                        LeftScore = stone_game_v_helper(Piles, Start, X - 1, DP),
                        RightScore = stone_game_v_helper(Piles, X + 1, End, DP),
                        MaxScore = max(MaxScore, Sum - min(LeftScore, RightScore))
                end
            end, lists:seq(Start, End)),
            DP(Start, End) = MaxScore,
            MaxScore
    end.