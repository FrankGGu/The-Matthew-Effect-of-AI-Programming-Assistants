-module(decode_ways).
-export([num_decodings/1]).

num_decodings(S) ->
    num_decodings(S, []).

num_decodings([], Acc) ->
    case Acc of
        [] -> 1;
        _ -> lists:last(Acc)
    end;
num_decodings(S, Acc) ->
    N = length(S),
    case Acc of
        [] ->
            num_decodings(S, [num_decodings_helper(S, 1, 0)]);
        _ ->
            Last = lists:last(Acc),
            num_decodings(S, Acc ++ [num_decodings_helper(S, Last, length(Acc))])
    end.

num_decodings_helper(S, Prev, Index) ->
    N = length(S),
    if Index >= N then
        1
    else
        case string:substring(S, Index+1, 1) of
            "0" ->
                case Index > 0 andalso string:substring(S, Index, 2) =/= "10" andalso string:substring(S, Index, 2) =/= "20" of
                    true -> 0;
                    false -> 0
                end;
            _ ->
                OneDigit := 1,
                TwoDigits :=
                    case Index+1 < N andalso
                         string:substring(S, Index+1, 1) =/= "0" andalso
                         string:substring(S, Index+1, 2) =< "26" andalso
                         string:substring(S, Index+1, 2) >= "10"
                    of
                        true -> 1;
                        false -> 0
                    end,
                OneDigit + TwoDigits
        end
    end.