-module(solution).
-export([die_simulator/3]).

die_simulator(N, RollMax, _) ->
    Mod = 1000000007,
    Memo = maps:new(),
    {Result, _} = dp(0, 0, 0, N, RollMax, Mod, Memo),
    Result.

dp(Prev, Consec, Rolled, N, RollMax, Mod, Memo) ->
    case Rolled of
        N ->
            {1, Memo};
        _ ->
            case maps:find({Prev, Consec, Rolled}, Memo) of
                {ok, Val} ->
                    {Val, Memo};
                error ->
                    Total = lists:foldl(fun(Next, Sum) ->
                        case Next of
                            Prev ->
                                case Consec < lists:nth(Prev, RollMax) of
                                    true ->
                                        {Cnt, NewMemo} = dp(Next, Consec + 1, Rolled + 1, N, RollMax, Mod, Memo),
                                        {(Sum + Cnt) rem Mod, NewMemo};
                                    false ->
                                        {Sum rem Mod, Memo}
                                end;
                            _ ->
                                {Cnt, NewMemo} = dp(Next, 1, Rolled + 1, N, RollMax, Mod, Memo),
                                {(Sum + Cnt) rem Mod, NewMemo}
                        end
                    end, {0, Memo}, lists:seq(1, 6)),
                    {Sum, NewMemo1} = Total,
                    {Sum, maps:put({Prev, Consec, Rolled}, Sum, NewMemo1)}
            end
    end.