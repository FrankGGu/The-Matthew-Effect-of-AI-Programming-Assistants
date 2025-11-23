-module(solution).
-export([findTheStringWithLCP/1]).

dsu_new(N) ->
    {array:from_list(lists:seq(0, N - 1)), array:from_list(lists:duplicate(N, 0))}.

dsu_find(Parent, I) ->
    P_I = array:get(I, Parent),
    if
        P_I == I -> {Parent, I};
        true ->
            {NewParent, Root} = dsu_find(Parent, P_I),
            {array:set(I, Root, NewParent), Root}
    end.

dsu_union(Parent, Rank, I, J) ->
    {Parent1, RootI} = dsu_find(Parent, I),
    {Parent2, RootJ} = dsu_find(Parent1, J),
    if
        RootI == RootJ -> {Parent2, Rank, false};
        true ->
            RankI = array:get(RootI, Rank),
            RankJ = array:get(RootJ, Rank),
            if
                RankI < RankJ ->
                    NewParent = array:set(RootI, RootJ, Parent2),
                    {NewParent, Rank, true};
                RankI > RankJ ->
                    NewParent = array:set(RootJ, RootI, Parent2),
                    {NewParent, Rank, true};
                true ->
                    NewParent = array:set(RootJ, RootI, Parent2),
                    NewRank = array:set(RootI, RankI + 1, Rank),
                    {NewParent, NewRank, true}
            end
    end.

findTheStringWithLCP(LcpList) ->
    N = length(LcpList),
    Lcp = [list_to_tuple(Row) || Row <- LcpList],

    {Parent, Rank} = dsu_new(N),

    Result = check_and_union(0, 0, N, Lcp, Parent, Rank),
    case Result of
        "impossible" -> "";
        {FinalParent, FinalRank} ->
            CharMap = array:new(N, {default, 0}),
            NextCharCode = $a,
            {FinalCharMap, _, CharAssignResult} = assign_chars(0, N, FinalParent, CharMap, NextCharCode),
            case CharAssignResult of
                "impossible" -> "";
                "ok" ->
                    S_chars = build_string_chars(0, N, FinalParent, FinalCharMap, []),
                    S = list_to_binary(lists:reverse(S_chars)),

                    FinalCheckResult = final_consistency_check(0, 0, N, Lcp, S),
                    case FinalCheckResult of
                        "impossible" -> "";
                        "ok" -> S
                    end
            end
    end.

check_and_union(I, J, N, Lcp, Parent, Rank) when I < N ->
    if
        J < N ->
            Lcp_IJ = element(J + 1, element(I + 1, Lcp)),

            if I == J ->
                if Lcp_IJ /= N - I ->
                    "impossible";
                true ->
                    check_and_union(I, J + 1, N, Lcp, Parent, Rank)
                end;
            true ->
                Lcp_JI = element(I + 1, element(J + 1, Lcp)),
                if Lcp_IJ /= Lcp_JI ->
                    "impossible";
                true ->
                    {TempParent, TempRank, _} = if Lcp_IJ > 0 ->
                                                    dsu_union(Parent, Rank, I, J);
                                                true ->
                                                    {Parent, Rank, false}
                                                end,

                    CheckResult = if Lcp_IJ > 0 ->
                                      if I + 1 < N andalso J + 1 < N ->
                                          Lcp_I1J1 = element(J + 1 + 1, element(I + 1 + 1, Lcp)),
                                          if Lcp_I1J1 /= Lcp_IJ - 1 ->
                                              "impossible";
                                          true ->
                                              "ok"
                                          end;
                                      true ->
                                          if Lcp_IJ /= 1 ->
                                              "impossible";
                                          true ->
                                              "ok"
                                          end
                                      end;
                                  true ->
                                      "ok"
                                  end,

                    if CheckResult == "impossible" ->
                        "impossible";
                    true ->
                        check_and_union(I, J + 1, N, Lcp, TempParent, TempRank)
                    end
                end
            end;
        true ->
            check_and_union(I + 1, 0, N, Lcp, Parent, Rank)
    end;
check_and_union(N, _, N, Lcp, Parent, Rank) ->
    {Parent, Rank}.

assign_chars(I, N, Parent, CharMap, NextCharCode) when I < N ->
    {NewParentAfterFind, RootI} = dsu_find(Parent, I),
    AssignedChar = array:get(RootI, CharMap),
    if
        AssignedChar == 0 ->
            if NextCharCode > $z ->
                {CharMap, NextCharCode, "impossible"};
            true ->
                NewCharMap = array:set(RootI, NextCharCode, CharMap),
                assign_chars(I + 1, N, NewParentAfterFind, NewCharMap, NextCharCode + 1)
            end;
        true ->
            assign_chars(I + 1, N, NewParentAfterFind, CharMap, NextCharCode)
    end;
assign_chars(N, N, Parent, CharMap, NextCharCode) ->
    {CharMap, NextCharCode, "ok"}.

build_string_chars(I, N, Parent, CharMap, Acc) when I < N ->
    {NewParentAfterFind, RootI} = dsu_find(Parent, I),
    Char = array:get(RootI, CharMap),
    build_string_chars(I + 1, N, NewParentAfterFind, CharMap, [Char | Acc]);
build_string_chars(N, N, Parent, CharMap, Acc) ->
    Acc.

final_consistency_check(I, J, N, Lcp, S) when I < N ->
    if
        J < N ->
            Lcp_IJ = element(J + 1, element(I + 1, Lcp)),
            Char_I = binary:at(S, I),
            Char_J = binary:at(S, J),

            CheckResult = if Lcp_IJ == 0 ->
                                if Char_I == Char_J -> "impossible"; true -> "ok" end;
                            Lcp_IJ > 0 ->
                                if Char_I /= Char_J -> "impossible";
                                true ->
                                    K = Lcp_IJ,
                                    if I + K < N andalso J + K < N ->
                                        Char_IK = binary:at(S, I + K),
                                        Char_JK = binary:at(S, J + K),
                                        if Char_IK == Char_JK -> "impossible"; true -> "ok" end;
                                    true ->
                                        "ok"
                                    end
                                end
                            end,

            if CheckResult == "impossible" ->
                "impossible";
            true ->
                final_consistency_check(I, J + 1, N, Lcp, S)
            end;
        true ->
            final_consistency_check(I + 1, 0, N, Lcp, S)
    end;
final_consistency_check(N, _, N, Lcp, S) ->
    "ok".