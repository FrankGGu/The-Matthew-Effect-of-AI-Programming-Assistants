-module(solution).
-export([find_integer_added_to_array_ii/2]).

find_integer_added_to_array_ii(Nums1, Nums2) ->
    S1 = lists:sort(Nums1),
    S2 = lists:sort(Nums2),

    Candidates = sets:new(),

    LenS1 = length(S1),

    Candidates1 = sets:add(hd(S2) - lists:nth(1, S1), Candidates),
    Candidates2 = sets:add(hd(S2) - lists:nth(2, S1), Candidates1),
    Candidates3 = sets:add(hd(S2) - lists:nth(3, S1), Candidates2),

    Candidates4 = sets:add(lists:last(S2) - lists:nth(LenS1, S1), Candidates3),
    Candidates5 = sets:add(lists:last(S2) - lists:nth(LenS1 - 1, S1), Candidates4),
    Candidates6 = sets:add(lists:last(S2) - lists:nth(LenS1 - 2, S1), Candidates5),

    ValidX = lists:foldl(fun(X, Acc) ->
                                 case check(S1, S2, X) of
                                     true -> [X | Acc];
                                     false -> Acc
                                 end
                         end, [], sets:to_list(Candidates6)),

    lists:sort(ValidX).

check(S1, S2, X) ->
    S1_plus_X = lists:map(fun(E) -> E + X end, S1),

    check_loop(S1_plus_X, S2, 0).

check_loop([], [], RemovedCount) -> RemovedCount == 2;
check_loop(S1_rem, [], RemovedCount) -> (RemovedCount + length(S1_rem)) == 2;
check_loop([], _S2_rem, _RemovedCount) -> false;
check_loop([H1 | T1], [H2 | T2], RemovedCount) ->
    if
        H1 == H2 ->
            check_loop(T1, T2, RemovedCount);
        H1 < H2 ->
            check_loop(T1, [H2 | T2], RemovedCount + 1);
        H1 > H2 ->
            false
    end.