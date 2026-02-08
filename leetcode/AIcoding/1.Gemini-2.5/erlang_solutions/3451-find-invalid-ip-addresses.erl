-module(solution).
-export([is_invalid_ip/1]).

is_invalid_ip(IPString) ->
    not is_valid_ip_internal(IPString).

is_valid_ip_internal(IPString) ->
    Parts = string:tokens(IPString, "."),
    case length(Parts) of
        4 ->
            lists:all(fun is_valid_octet/1, Parts);
        _ ->
            false
    end.

is_valid_octet(OctetString) ->
    Len = length(OctetString),
    case Len of
        0 -> false;
        _ when Len > 1 andalso hd(OctetString) == $0 -> false;
        _ ->
            try list_to_integer(OctetString) of
                N when N >= 0 andalso N <= 255 -> true;
                _ -> false
            catch
                error:badarg -> false
            end
    end.