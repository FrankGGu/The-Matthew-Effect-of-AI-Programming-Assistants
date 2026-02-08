-spec min_score(Nums :: [integer()]) -> integer().
min_score(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    if
        N =< 3 ->
            0;
        true ->
            [H1, H2, H3 | _] = SortedNums,
            RevSortedNums = lists:reverse(SortedNums),
            [L1, L2, L3 | _] = RevSortedNums,

            % Case 1: Change two smallest elements (n1, n2). New min is n3. Score: nN - n3.
            Val1 = L1 - H3,
            % Case 2: Change two largest elements (nN, n(N-1)). New max is n(N-2). Score: n(N-2) - n1.
            Val2 = L3 - H1,
            % Case 3: Change one smallest (n1) and one largest (nN). New min is n2, new max is n(N-1). Score: n(N-1) - n2.
            Val3 = L2 - H2,

            min(Val1, min(Val2, Val3))
    end.