-module(router).
-export([new/0, add_route/3, lookup/2]).

new() ->
    {dict, dict:new()}.

add_route(Prefix, IP, Router) ->
    {dict, D} = Router,
    dict:store(Prefix, IP, D).

lookup(IP, Router) ->
    {dict, D} = Router,
    lists:reverse(lists:usort([Prefix || {Prefix, IPAddr} <- dict:to_list(D), match(IP, IPAddr)])).

match(IP, IP) ->
    true;
match(IP, IPRange) when is_list(IPRange) ->
    case string:split(IP, ".", 4) of
        [A1, A2, A3, A4] ->
            case string:split(IPRange, "/", 2) of
                [IPBase, CIDR] ->
                    {ok, Base} = erlang:list_to_integer(IPBase),
                    {ok, CidrNum} = erlang:list_to_integer(CIDR),
                    {ok, A1Int} = erlang:list_to_integer(A1),
                    {ok, A2Int} = erlang:list_to_integer(A2),
                    {ok, A3Int} = erlang:list_to_integer(A3),
                    {ok, A4Int} = erlang:list_to_integer(A4),
                    BaseInt = (A1Int bsl 24) + (A2Int bsl 16) + (A3Int bsl 8) + A4Int,
                    Mask = (1 bsl CidrNum) - 1,
                    (BaseInt band Mask) == (BaseInt band Mask);
                _ ->
                    false
            end;
        _ ->
            false
    end.