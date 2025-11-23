-spec longest_common_subsequence(Text1 :: unicode:unicode_binary(), Text2 :: unicode:unicode_binary()) -> integer().
longest_common_subsequence(Text1, Text2) ->
    S1 = unicode:characters_to_list(Text1),
    S2 = unicode:characters_to_list(Text2),
    M = length(S1),
    N = length(S2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    UpdatedDP = lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            case I > 0 andalso J > 0 of
                true ->
                    case lists:nth(I, S1) =:= lists:nth(J, S2) of
                        true ->
                            Val = lists:nth(I, lists:nth(J + 1, AccJ)) + 1,
                            set(AccJ, I + 1, J + 1, Val);
                        false ->
                            Max = max(lists:nth(I + 1, lists:nth(J, AccJ)), lists:nth(I, lists:nth(J + 1, AccJ))),
                            set(AccJ, I + 1, J + 1, Max)
                    end;
                false ->
                    AccJ
            end
        end, AccI, lists:seq(1, N))
    end, DP, lists:seq(1, M)),
    lists:nth(M + 1, lists:nth(N + 1, UpdatedDP)).

set(List, Row, Col, Value) ->
    RowList = lists:nth(Row, List),
    UpdatedRowList = setelement(Col, list_to_tuple(RowList), Value),
    setelement(Row, list_to_tuple(List), tuple_to_list(UpdatedRowList)).