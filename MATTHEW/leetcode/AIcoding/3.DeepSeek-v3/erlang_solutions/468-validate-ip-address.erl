-module(solution).
-export([validIPAddress/1]).

validIPAddress(IP) ->
    case is_ipv4(IP) of
        true -> "IPv4";
        false ->
            case is_ipv6(IP) of
                true -> "IPv6";
                false -> "Neither"
            end
    end.

is_ipv4(IP) ->
    case string:tokens(IP, ".") of
        [A, B, C, D] ->
            is_ipv4_part(A) andalso is_ipv4_part(B) andalso is_ipv4_part(C) andalso is_ipv4_part(D);
        _ -> false
    end.

is_ipv4_part(Part) ->
    case catch list_to_integer(Part) of
        N when is_integer(N), N >= 0, N =< 255 ->
            (length(Part) > 1 andalso hd(Part) =/= $0) orelse length(Part) =:= 1;
        _ -> false
    end.

is_ipv6(IP) ->
    case string:tokens(IP, ":") of
        Parts when length(Parts) =:= 8 ->
            lists:all(fun is_ipv6_part/1, Parts);
        _ -> false
    end.

is_ipv6_part(Part) ->
    case Part of
        "" -> false;
        _ ->
            Len = length(Part),
            Len =< 4 andalso lists:all(fun(C) -> is_hex_char(C) end, Part)
    end.

is_hex_char(C) ->
    (C >= $0 andalso C =< $9) orelse
    (C >= $a andalso C =< $f) orelse
    (C >= $A andalso C =< $F).