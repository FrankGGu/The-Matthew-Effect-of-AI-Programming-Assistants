-module(solution).
-export([valid_ip_address/1]).

-spec valid_ip_address(unicode:unicode_binary()) -> unicode:unicode_binary().
valid_ip_address(QueryIP) ->
    case validate_ipv4(QueryIP) of
        true -> "IPv4";
        false -> 
            case validate_ipv6(QueryIP) of
                true -> "IPv6";
                false -> "Neither"
            end
    end.

-spec validate_ipv4(unicode:unicode_binary()) -> boolean().
validate_ipv4(QueryIP) ->
    case string:tokens(QueryIP, ".") of
        [X1, X2, X3, X4] -> 
            validate_ipv4_part(X1) andalso validate_ipv4_part(X2) andalso 
            validate_ipv4_part(X3) andalso validate_ipv4_part(X4);
        _ -> false
    end.

-spec validate_ipv4_part(unicode:unicode_binary()) -> boolean().
validate_ipv4_part(Part) ->
    case list_to_integer(Part) of
        N when N >= 0, N =< 255 -> not string:startswith(Part, "0");
        _ -> false
    end.

-spec validate_ipv6(unicode:unicode_binary()) -> boolean().
validate_ipv6(QueryIP) ->
    case string:tokens(QueryIP, ":") of
        List when length(List) == 8 -> 
            lists:all(fun validate_ipv6_part/1, List);
        _ -> false
    end.

-spec validate_ipv6_part(unicode:unicode_binary()) -> boolean().
validate_ipv6_part(Part) ->
    length(Part) >= 1 andalso length(Part) =< 4 andalso is_hexadecimal(Part).

-spec is_hexadecimal(unicode:unicode_binary()) -> boolean().
is_hexadecimal(Part) ->
    lists:all(fun(C) -> is_hex_digit(C) end, list:to_list(Part)).

-spec is_hex_digit(char()) -> boolean().
is_hex_digit(C) when C >= $0 andalso C =< $9 -> true;
is_hex_digit(C) when C >= $a andalso C =< $f -> true;
is_hex_digit(C) when C >= $A andalso C =< $F -> true;
is_hex_digit(_) -> false.
