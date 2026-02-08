-module(can_i_win).
-export([canIWin/2]).

canIWin(Num, max) ->
    canIWin(Num, max, 0, 1, []).

canIWin(Num, Max, Sum, Step, Memo) ->
    Key = {Sum, Step},
    case lists:keyfind(Key, 1, Memo) of
        {Key, Result} ->
            Result;
        false ->
            if
                Sum >= Max ->
                    true;
                true ->
                    Res = not canIWin(Num, Max, Sum + Step, Step + 1, [{Key, false} | Memo]),
                    case lists:keyfind(Key, 1, Memo) of
                        false ->
                            canIWin(Num, Max, Sum, Step + 1, [{Key, Res} | Memo]);
                        _ ->
                            Res
                    end
            end
    end.