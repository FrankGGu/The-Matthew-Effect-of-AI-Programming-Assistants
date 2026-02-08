-module(solution).
-export([is_valid_ip/1]).

is_valid_ip(IP) ->
    case string:find(IP, ".") of
        nomatch ->
            case string:find(IP, ":") of
                nomatch -> "Neither";
                _ -> is_ipv6(IP)
            end;
        _ ->
            is_ipv4(IP)
    end.

is_ipv4(IP) ->
    Parts = string:tokens(IP, "."),
    case length(Parts) of
        4 ->
            case lists:all(fun is_valid_ipv4_part/1, Parts) of
                true -> "IPv4";
                false -> "Neither"
            end;
        _ -> "Neither"
    end.

is_valid_ipv4_part(Part) ->
    Len = string:len(Part),
    case Len of
        0 -> false;
        _ ->
            case re:run(Part, "^(0|[1-9][0-9]*)$", [{return, list}]) of
                nomatch -> false;
                _ ->
                    try
                        IntVal = list_to_integer(Part),
                        IntVal >= 0 andalso IntVal =< 255
                    catch
                        error:badarg -> false
                    end
            end
    end.

is_ipv6(IP) ->
    Parts = string:tokens(IP, ":"),
    case length(Parts) of
        8 ->
            case lists:all(fun is_valid_ipv6_part/1, Parts) of
                true -> "IPv6";
                false -> "Neither"
            end;
        _ -> "Neither"
    end.

is_valid_ipv6_part(Part) ->
    Len = string:len(Part),
    case Len of
        0 -> false;
        _ when Len > 4 -> false;
        _ ->
            case re:run(Part, "^[0-9a-fA-F]+$", [{return, list}]) of
                nomatch -> false;
                _ -> true
            end
    end.