-module(decode_ways_ii).
-export([num_decodings/1]).

num_decodings(S) ->
    num_decodings(S, 1, 0, 0).

num_decodings([], _, _, Count) ->
    Count;
num_decodings([C | Rest], Pos, Prev1, Prev2) ->
    Current = case C of
                  $* -> 0;
                  _ -> C - $0
              end,
    NewCount = 0,
    if
        Current == 0 ->
            NewCount = 0;
        true ->
            NewCount = Prev1
    end,
    if
        Pos >= 2 ->
            TwoDigit = (Prev1 - $0) * 10 + Current,
            if
                TwoDigit >= 10 andalso TwoDigit =< 26 ->
                    NewCount = NewCount + Prev2;
                true ->
                    NewCount = NewCount
            end;
        true ->
            NewCount = NewCount
    end,
    num_decodings(Rest, Pos + 1, NewCount, Prev1).