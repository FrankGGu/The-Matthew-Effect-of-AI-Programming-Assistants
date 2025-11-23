-module(solution).
-export([readBinaryWatch/1]).

-spec readBinaryWatch(TurnedOn :: integer()) -> [string()].
readBinaryWatch(TurnedOn) ->
    lists:foldl(fun(H, AccH) ->
        lists:foldl(fun(M, AccM) ->
            case count_set_bits(H) + count_set_bits(M) of
                TurnedOn ->
                    FormattedTime = io_lib:format("~w:~s~w", [H, if M < 10 -> "0"; true -> "" end, M]),
                    [lists:flatten(FormattedTime) | AccM];
                _ ->
                    AccM
            end
        end, AccH, lists:seq(0, 59))
    end, [], lists:seq(0, 11)).

count_set_bits(0) -> 0;
count_set_bits(N) when N > 0 -> 1 + count_set_bits(N band (N-1)).