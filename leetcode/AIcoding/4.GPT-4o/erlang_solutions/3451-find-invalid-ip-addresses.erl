-module(solution).
-export([find_invalid_ip_addresses/1]).

find_invalid_ip_addresses(IPAddresses) ->
    lists:filter(fun(IP) -> not valid_ip(IP) end, IPAddresses).

valid_ip(IP) ->
    case string:split(IP, ".", all) of
        [A, B, C, D] ->
            valid_segment(A) andalso valid_segment(B) andalso valid_segment(C) andalso valid_segment(D);
        _ -> false
    end.

valid_segment(Segment) ->
    case string:to_integer(Segment) of
        {ok, Num} when Num >= 0, Num =< 255 ->
            (Segment =:= integer_to_list(Num) orelse 
             (string:to_integer(Segment) =:= {ok, 0} andalso Segment =:= "0"));
        _ -> false
    end.