-module(solution).
-export([count_special_subsequences/1]).

count_special_subsequences(Seq) ->
    N = length(Seq),
    Mod = 1000000007,
    DP = lists:duplicate(N + 1, 0),
    DP1 = lists:duplicate(N + 1, 0),
    DP2 = lists:duplicate(N + 1, 0),
    DP3 = lists:duplicate(N + 1, 0),
    lists:foldl(fun({C, I}, {DP, DP1, DP2, DP3}) ->
        case C of
            $0 -> 
                DP2_next = (DP1 + DP2) rem Mod,
                {lists:append(DP2, [DP2_next]), 
                 lists:append(DP1, [DP1]), 
                 lists:append(DP3, [DP3])};
            $1 -> 
                DP1_next = (DP2 + DP1) rem Mod,
                {lists:append(DP2, [DP2]), 
                 lists:append(DP1, [DP1_next]), 
                 lists:append(DP3, [DP3])};
            $2 -> 
                DP3_next = (DP3 + DP1) rem Mod,
                {lists:append(DP2, [DP2]), 
                 lists:append(DP1, [DP1]), 
                 lists:append(DP3, [DP3_next])}
        end
    end, {DP, DP1, DP2, DP3}, lists:zip(Seq, lists:seq(1, N))),
    lists:last(DP3).