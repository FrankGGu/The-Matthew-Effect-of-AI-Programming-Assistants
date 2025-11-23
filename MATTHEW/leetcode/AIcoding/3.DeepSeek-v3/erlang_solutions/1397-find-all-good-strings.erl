-module(solution).
-export([find_good_strings/4]).

find_good_strings(N, S1, S2, Evil) ->
    {ok, Mod} = application:get_env(solution, mod, 1000000007),
    EvilLen = length(Evil),
    S1Len = length(S1),
    S2Len = length(S2),
    if
        S1Len =/= N; S2Len =/= N -> 0;
        true ->
            DP = init_dp(N, EvilLen, Mod),
            {S1Num, _} = count(S1, Evil, DP, Mod),
            {S2Num, _} = count(S2, Evil, DP, Mod),
            Total = (S2Num - S1Num + Mod) rem Mod,
            case string:str(S1, Evil) of
                0 -> (Total + 1) rem Mod;
                _ -> Total rem Mod
            end
    end.

init_dp(N, M, Mod) ->
    DP = array:new([{size, N + 1}, {default, array:new([{size, M}, {default, -1}])}]),
    DP.

count(S, Evil, DP, Mod) ->
    M = length(Evil),
    {Res, _} = count_helper(S, Evil, 0, 0, true, DP, Mod),
    {Res, DP}.

count_helper(S, Evil, Pos, EvilPos, IsTight, DP, Mod) ->
    M = length(Evil),
    N = length(S),
    if
        EvilPos =:= M -> {0, DP};
        Pos =:= N -> {1, DP};
        true ->
            case array:get(Pos, array:get(EvilPos, DP)) of
                -1 ->
                    Limit = if
                        IsTight -> lists:nth(Pos + 1, S) - $a;
                        true -> 25
                    end,
                    {Sum, NewDP} = lists:foldl(
                        fun(D, {Acc, CurrDP}) ->
                            NewEvilPos = next_evil_pos(Evil, EvilPos, D + $a),
                            {Cnt, UpdatedDP} = count_helper(S, Evil, Pos + 1, NewEvilPos, IsTight and (D =:= Limit), CurrDP, Mod),
                            {(Acc + Cnt) rem Mod, UpdatedDP}
                        end,
                        {0, DP},
                        lists:seq(0, Limit)
                    ),
                    NewDP1 = array:set(Pos, array:set(EvilPos, Sum, array:get(Pos, NewDP)), NewDP),
                    {Sum, NewDP1};
                Cached ->
                    {Cached, DP}
            end
    end.

next_evil_pos(Evil, EvilPos, C) ->
    EvilLen = length(Evil),
    K = EvilPos,
    while_loop(K, C, Evil, EvilLen).

while_loop(K, C, Evil, EvilLen) ->
    if
        K < EvilLen ->
            CurrentChar = lists:nth(K + 1, Evil),
            if
                CurrentChar =:= C -> K + 1;
                true -> while_loop(get_lps(Evil, K), C, Evil, EvilLen)
            end;
        true -> get_lps(Evil, K)
    end.

get_lps(Evil, K) ->
    if
        K =:= 0 -> 0;
        true ->
            LPS = compute_lps(Evil),
            lists:nth(K, LPS)
    end.

compute_lps(Pattern) ->
    Len = length(Pattern),
    LPS = array:new([{size, Len}, {default, 0}]),
    compute_lps_helper(Pattern, LPS, 1, 0, Len).

compute_lps_helper(Pattern, LPS, I, Len, PatternLen) ->
    if
        I < PatternLen ->
            if
                lists:nth(I + 1, Pattern) =:= lists:nth(Len + 1, Pattern) ->
                    NewLen = Len + 1,
                    NewLPS = array:set(I, NewLen, LPS),
                    compute_lps_helper(Pattern, NewLPS, I + 1, NewLen, PatternLen);
                true ->
                    if
                        Len =/= 0 ->
                            NewLen = array:get(Len - 1, LPS),
                            compute_lps_helper(Pattern, LPS, I, NewLen, PatternLen);
                        true ->
                            NewLPS = array:set(I, 0, LPS),
                            compute_lps_helper(Pattern, NewLPS, I + 1, 0, PatternLen)
                    end
            end;
        true -> LPS
    end.