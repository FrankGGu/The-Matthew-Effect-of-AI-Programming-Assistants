-module(validate_ip_address).
-export([validIPAddress/1]).

validIPAddress(Addr) ->
    case string:split(Addr, ".", 4) of
        {A, B, C, D} when is_integer(A), is_integer(B), is_integer(C), is_integer(D) ->
            case [A, B, C, D] of
                [A, B, C, D] when A >= 0, A =< 255, B >= 0, B =< 255, C >= 0, C =< 255, D >= 0, D =< 255 ->
                    case [string:to_integer(string:trim(A)), string:to_integer(string:trim(B)), string:to_integer(string:trim(C)), string:to_integer(string:trim(D))] of
                        [[N1, _], [N2, _], [N3, _], [N4, _]] when N1 == A, N2 == B, N3 == C, N4 == D ->
                            "IPv4";
                        _ ->
                            "Neither"
                    end;
                _ ->
                    "Neither"
            end;
        _ ->
            case string:split(Addr, ":", 8) of
                {A, B, C, D, E, F, G, H} when is_binary(A), is_binary(B), is_binary(C), is_binary(D), is_binary(E), is_binary(F), is_binary(G), is_binary(H) ->
                    case [A, B, C, D, E, F, G, H] of
                        [A, B, C, D, E, F, G, H] ->
                            case lists:all(fun(X) -> is_hex(X) end, [A, B, C, D, E, F, G, H]) of
                                true ->
                                    "IPv6";
                                false ->
                                    "Neither"
                            end;
                        _ ->
                            "Neither"
                    end;
                _ ->
                    "Neither"
            end
    end.

is_hex(S) ->
    case string:to_integer(S, 16) of
        {ok, _, _} ->
            case string:length(S) of
                L when L >= 1, L =< 4 ->
                    true;
                _ ->
                    false
            end;
        _ ->
            false
    end.