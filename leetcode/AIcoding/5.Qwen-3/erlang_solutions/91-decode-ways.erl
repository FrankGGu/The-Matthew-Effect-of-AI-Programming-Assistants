-module(decode_ways).
-export([num_decodings/1]).

num_decodings(S) ->
    num_decodings(S, 0, 1, 0).

num_decodings([], _, Count, _) -> Count;
num_decodings([H|T], Index, Count, Prev) ->
    case H of
        $0 -> 
            if Index == 0 -> num_decodings(T, Index + 1, 0, 0);
               true -> num_decodings(T, Index + 1, Count, 0)
            end;
        _ ->
            NewCount = Count + Prev,
            case T of
                [] -> num_decodings(T, Index + 1, NewCount, 0);
                _ ->
                    FirstDigit = H - $0,
                    SecondDigit = hd(T) - $0,
                    if (FirstDigit * 10 + SecondDigit) >= 10 andalso (FirstDigit * 10 + SecondDigit) =< 26 ->
                        num_decodings(T, Index + 1, NewCount, Count);
                       true ->
                        num_decodings(T, Index + 1, NewCount, 0)
                    end
            end
    end.