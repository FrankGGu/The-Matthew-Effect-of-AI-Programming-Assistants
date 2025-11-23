-module(solution).
-export([restore_ip_address/1]).

restore_ip_address(S) ->
    restore_ip_address(S, 0, []).

restore_ip_address(_, 4, Parts) when length(Parts) == 4 ->
    lists:join(".", lists:reverse(Parts));
restore_ip_address(_, 4, _) ->
    [];
restore_ip_address([], _, _) ->
    [];
restore_ip_address(S, N, Parts) ->
    case N of
        0 -> 
            restore_ip_address(S, 1, []);
        _ -> 
            lists:flatmap(fun(I) ->
                case I of
                    1 -> 
                        [H | T] = S,
                        if H == $0 andalso length(S) > 1 -> [];
                           true -> 
                                Part = [H],
                                restore_ip_address(T, N + 1, [Part | Parts])
                        end;
                    _ -> 
                        [H | T] = S,
                        if length(S) < I -> [];
                           true ->
                                Part = lists:sublist(S, I),
                                if hd(Part) == $0 andalso length(Part) > 1 -> [];
                                   true ->
                                        Val = list_to_integer(Part),
                                        if Val >= 0 andalso Val =< 255 ->
                                            restore_ip_address(lists:nthtail(I, S), N + 1, [Part | Parts]);
                                           true -> []
                                        end
                                end
                        end
                end
            end, [1,2,3]).

list_to_integer(List) ->
    list_to_integer(List, 0).

list_to_integer([], Acc) ->
    Acc;
list_to_integer([C | T], Acc) ->
    list_to_integer(T, Acc * 10 + (C - $0)).