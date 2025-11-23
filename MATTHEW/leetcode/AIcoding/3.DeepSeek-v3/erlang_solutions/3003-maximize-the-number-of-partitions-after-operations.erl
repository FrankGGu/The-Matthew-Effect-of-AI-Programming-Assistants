-module(solution).
-export([max_partitions_after_operations/2]).

max_partitions_after_operations(S, K) ->
    N = length(S),
    Mem = maps:new(),
    {Ans, _} = dp(1, 0, 0, 0, S, K, N, Mem),
    Ans.

dp(Pos, Mask, Changed, Parts, S, K, N, Mem) ->
    Key = {Pos, Mask, Changed, Parts},
    case maps:find(Key, Mem) of
        {ok, Val} ->
            {Val, Mem};
        error ->
            if
                Pos > N ->
                    NewParts = if
                        Mask == 0 -> Parts;
                        true -> Parts + 1
                    end,
                    {NewParts, maps:put(Key, NewParts, Mem)};
                true ->
                    Char = lists:nth(Pos, S),
                    Bit = 1 bsl (Char - $a),
                    NewMask = Mask bor Bit,
                    if
                        NewMask =< K ->
                            {Res1, Mem1} = dp(Pos + 1, NewMask, Changed, Parts, S, K, N, Mem),
                            if
                                Changed == 0 ->
                                    MaxRes = Res1,
                                    lists:foldl(fun(C, {Max, M}) ->
                                        NewBit = 1 bsl (C - $a),
                                        NewNewMask = Mask bor NewBit,
                                        if
                                            NewNewMask =< K ->
                                                {Res, M1} = dp(Pos + 1, NewNewMask, 1, Parts, S, K, N, M),
                                                {max(Max, Res), M1};
                                            true ->
                                                {Res, M1} = dp(Pos + 1, NewBit, 1, Parts + 1, S, K, N, M),
                                                {max(Max, Res), M1}
                                        end
                                    end, {MaxRes, Mem1}, lists:seq($a, $z));
                                true ->
                                    {Res1, Mem1}
                            end;
                        true ->
                            {Res1, Mem1} = dp(Pos + 1, Bit, Changed, Parts + 1, S, K, N, Mem),
                            if
                                Changed == 0 ->
                                    MaxRes = Res1,
                                    lists:foldl(fun(C, {Max, M}) ->
                                        NewBit = 1 bsl (C - $a),
                                        if
                                            (Mask bor NewBit) =< K ->
                                                {Res, M1} = dp(Pos + 1, Mask bor NewBit, 1, Parts, S, K, N, M),
                                                {max(Max, Res), M1};
                                            true ->
                                                {Res, M1} = dp(Pos + 1, NewBit, 1, Parts + 1, S, K, N, M),
                                                {max(Max, Res), M1}
                                        end
                                    end, {MaxRes, Mem1}, lists:seq($a, $z));
                                true ->
                                    {Res1, Mem1}
                            end
                    end
            end
    end.