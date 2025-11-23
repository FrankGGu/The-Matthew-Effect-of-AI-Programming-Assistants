-module(solution).
-export([find_invalid_ips/1]).

find_invalid_ips(Input) ->
    lists:filter(fun(Ip) -> is_invalid(Ip) end, Input).

is_invalid(Ip) ->
    case string:split(Ip, ".", all) of
        [A,B,C,D] when length(A) > 0, length(B) > 0, length(C) > 0, length(D) > 0 ->
            try
                ANum = list_to_integer(A),
                BNum = list_to_integer(B),
                CNum = list_to_integer(C),
                DNum = list_to_integer(D),
                ANum >= 0 andalso ANum =< 255 andalso
                BNum >= 0 andalso BNum =< 255 andalso
                CNum >= 0 andalso CNum =< 255 andalso
                DNum >= 0 andalso DNum =< 255 andalso
                (A =:= integer_to_list(ANum) andalso B =:= integer_to_list(BNum) andalso C =:= integer_to_list(CNum) andalso D =:= integer_to_list(DNum))
            catch
                _ -> false
            end;
        _ ->
            false
    end.