-module(solution).
-export([restore_ip_addresses/1]).

restore_ip_addresses(S) ->
    N = length(S),
    if
        N < 4; N > 12 -> [];
        true -> backtrack(S, 1, [], [])
    end.

backtrack(S, Pos, Current, Acc) when Pos > length(S) ->
    case length(Current) of
        4 -> [string:join(lists:reverse(Current), "." | Acc];
        _ -> Acc
    end;
backtrack(S, Pos, Current, Acc) ->
    case length(Current) of
        4 -> Acc;
        _ ->
            MaxLen = min(3, length(S) - Pos + 1),
            lists:foldl(fun(Len, A) ->
                Segment = string:substr(S, Pos, Len),
                case valid_segment(Segment) of
                    true -> backtrack(S, Pos + Len, [Segment | Current], A);
                    false -> A
                end
            end, Acc, lists:seq(1, MaxLen))
    end.

valid_segment(Segment) ->
    case string:to_integer(Segment) of
        {Num, []} when Num =< 255 ->
            case length(Segment) of
                1 -> true;
                _ -> hd(Segment) /= $0
            end;
        _ -> false
    end.