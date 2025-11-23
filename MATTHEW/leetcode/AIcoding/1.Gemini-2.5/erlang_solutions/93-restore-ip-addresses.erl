-module(solution).
-export([restoreIpAddresses/1]).

restoreIpAddresses(S) ->
    LenS = length(S),
    Results = restore(S, LenS, 4),
    lists:map(fun(Parts) -> string:join(Parts, ".") end, Results).

is_valid_part(PartStr) when is_list(PartStr) ->
    Len = length(PartStr),
    if
        Len == 0 -> false;
        Len > 1 andalso hd(PartStr) == $0 -> false;
        true ->
            try
                Num = list_to_integer(PartStr),
                Num >= 0 andalso Num <= 255
            catch
                error:badarg -> false
            end
    end.

restore(S, LenS, PartsLeft) ->
    if
        PartsLeft == 0 ->
            if
                LenS == 0 -> [[]];
                true -> []
            end;
        LenS == 0 -> [];
        true ->
            MaxLenPart = min(3, LenS),
            generate_parts(S, LenS, PartsLeft, 1, MaxLenPart, [])
    end.

generate_parts(S, LenS, PartsLeft, CurrentLen, MaxLenPart, Acc) when CurrentLen =< MaxLenPart ->
    Part = string:substr(S, 1, CurrentLen),
    Rest = string:substr(S, CurrentLen + 1),
    RestLen = LenS - CurrentLen,
    NewAcc = if
        is_valid_part(Part) ->
            SubResults = restore(Rest, RestLen, PartsLeft - 1),
            lists:foldl(fun(SubResult, ResAcc) ->
                                [ [Part | SubResult] | ResAcc ]
                        end, Acc, SubResults);
        true -> Acc
    end,
    generate_parts(S, LenS, PartsLeft, CurrentLen + 1, MaxLenPart, NewAcc);
generate_parts(_S, _LenS, _PartsLeft, _CurrentLen, _MaxLenPart, Acc) ->
    Acc.