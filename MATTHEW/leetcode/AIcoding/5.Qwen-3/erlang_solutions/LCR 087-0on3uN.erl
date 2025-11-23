-module(recover_ip_addresses).
-export([restore_ip/1]).

restore_ip(S) ->
    restore_ip(S, 0, [], []).

restore_ip(_, 4, [A,B,C,D], Acc) ->
    case is_valid(A) andalso is_valid(B) andalso is_valid(C) andalso is_valid(D) of
        true -> [lists:flatten([integer_to_list(A), ".", integer_to_list(B), ".", integer_to_list(C), ".", integer_to_list(D)]) | Acc];
        false -> Acc
    end;
restore_ip([], _, _, Acc) ->
    Acc;
restore_ip([C|T], N, Parts, Acc) ->
    case N of
        0 -> restore_ip(T, 1, [C], Acc);
        _ ->
            case length(Parts) < 4 of
                true ->
                    NewPart = (lists:foldl(fun(X, Acc2) -> Acc2 * 10 + X end, 0, Parts)) * 10 + C,
                    if
                        NewPart > 255 -> Acc;
                        true -> restore_ip(T, N+1, [NewPart], Acc)
                    end;
                false -> Acc
            end
    end.

is_valid(N) when N >= 0, N =< 255 ->
    true;
is_valid(_) ->
    false.