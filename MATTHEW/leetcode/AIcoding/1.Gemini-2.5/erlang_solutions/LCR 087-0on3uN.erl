-module(solution).
-export([restore_ip_addresses/1]).

restore_ip_addresses(S) ->
    S_chars = string:to_list(S),
    backtrack(S_chars, 0, 0, [], length(S_chars)).

backtrack(S_chars, StartIdx, PartsCount, CurrentPartsAcc, LenS) ->
    if
        PartsCount == 4 ->
            if StartIdx == LenS ->
                [string:join(lists:reverse(CurrentPartsAcc), ".")]
            else
                []
            end;
        StartIdx == LenS ->
            [];
        true ->
            lists:foldl(fun(Len, Acc) ->
                EndIdx = StartIdx + Len - 1,
                if EndIdx >= LenS ->
                    Acc;
                true ->
                    SubStringChars = lists:sublist(S_chars, StartIdx + 1, Len),
                    PartStr = lists:flatten(SubStringChars),

                    Valid =
                        case PartStr of
                            "0" -> true;
                            [H|_] when H == $0 -> false;
                            _ ->
                                PartInt = list_to_integer(PartStr),
                                PartInt >= 0 andalso PartInt <= 255
                        end,

                    if Valid ->
                        NewResults = backtrack(S_chars, StartIdx + Len, PartsCount + 1, [PartStr | CurrentPartsAcc], LenS),
                        Acc ++ NewResults;
                    true ->
                        Acc
                    end
                end
            end, [], [1, 2, 3])
    end.