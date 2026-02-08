-module(solution).
-export([restore_array/2]).

restore_array(S, K) ->
    N = length(S),
    Mod = 1000000007,
    K_str_len = length(integer_to_list(K)),
    Memo = gb_trees:empty(),

    {Result, _FinalMemo} = solve(0, S, K, N, Mod, K_str_len, Memo),
    Result.

solve(N, _S_suffix, _K, N, _Mod, _K_str_len, Memo) ->
    {1, Memo};
solve(Idx, S_suffix, K, N, Mod, K_str_len, Memo) ->
    case gb_trees:lookup(Idx, Memo) of
        {value, Val} -> {Val, Memo};
        none ->
            [Char | _Rest] = S_suffix,
            if Char == $0 ->
                {0, gb_trees:insert(Idx, 0, Memo)};
            true ->
                {FinalWays, UpdatedMemo} = 
                    inner_loop(Idx, Idx, S_suffix, K, N, Mod, 0, 0, Memo, K_str_len),

                {FinalWays, gb_trees:insert(Idx, FinalWays, UpdatedMemo)}
            end
    end.

inner_loop(StartIdx, CurrentJ, [], _K, _N, _Mod, _CurrentNum, AccWays, Memo, _K_str_len) ->
    {AccWays, Memo};
inner_loop(StartIdx, CurrentJ, [Char | RestChars], K, N, Mod, CurrentNum, AccWays, Memo, K_str_len) ->
    if (CurrentJ - StartIdx + 1) > K_str_len ->
        {AccWays, Memo};
    true ->
        Digit = Char - $0,
        NewNum = CurrentNum * 10 + Digit,

        if NewNum > K ->
            {AccWays, Memo};
        true ->
            {SubWays, UpdatedMemo} = solve(CurrentJ + 1, RestChars, K, N, Mod, K_str_len, Memo),

            NewAccWays = (AccWays + SubWays) rem Mod,

            inner_loop(StartIdx, CurrentJ + 1, RestChars, K, N, Mod, NewNum, NewAccWays, UpdatedMemo, K_str_len)
        end
    end.