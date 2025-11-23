-module(number_of_beautiful_partitions).
-export([number_of_beautiful_partitions/2]).

number_of_beautiful_partitions(S, K) ->
    Len = length(S),
    number_of_beautiful_partitions(S, K, Len).

number_of_beautiful_partitions(S, K, Len) ->
    Mod = 1000000007,
    dp(S, K, Len, Mod).

dp(S, K, Len, Mod) ->
    Memo = dict:new(),
    dp(0, K, S, Len, Mod, Memo).

dp(Index, Partitions, S, Len, Mod, Memo) ->
    case dict:find({Index, Partitions}, Memo) of
        {ok, Value} ->
            Value;
        error ->
            Result =
                case {Index >= Len, Partitions =:= 0} of
                    {true, true} ->
                        1;
                    {true, false} ->
                        0;
                    {false, true} ->
                        0;
                    {false, false} ->
                        case is_beautiful(lists:sublist(S, Index+1, 1)) of
                            true ->
                                FoldFun = fun(J, Acc) ->
                                    case is_beautiful(lists:sublist(S, Index + 1, J - Index)) of
                                        true ->
                                            (Acc + dp(J, Partitions - 1, S, Len, Mod, Memo)) rem Mod;
                                        false ->
                                            Acc
                                    end
                                end,
                                lists:foldl(FoldFun, 0, lists:seq(Index + K, Len));
                            false ->
                                0
                        end
                end,
            dict:store({Index, Partitions}, Result, Memo),
            Result
    end.

is_beautiful([H|_]) ->
    H >= 2 andalso H =< 9.