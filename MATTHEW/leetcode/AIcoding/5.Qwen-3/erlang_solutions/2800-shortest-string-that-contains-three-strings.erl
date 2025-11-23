-module(solution).
-export([minimum_string/3]).

-spec minimum_string(A :: unicode:unicode_binary(), B :: unicode:unicode_binary(), C :: unicode:unicode_binary()) -> unicode:unicode_binary().

minimum_string(A, B, C) ->
    AStr = binary_to_list(A),
    BStr = binary_to_list(B),
    CStr = binary_to_list(C),
    Perms = permutations([AStr, BStr, CStr]),
    Merges = lists:foldl(fun(P, Acc) ->
        [merge(lists:nth(1, P), lists:nth(2, P), lists:nth(3, P)) | Acc]
    end, [], Perms),
    lists:min(Merges).

merge(A, B, C) ->
    AB = merge_two(A, B),
    ABC = merge_two(AB, C),
    AC = merge_two(A, C),
    ACB = merge_two(AC, B),
    BA = merge_two(B, A),
    BAC = merge_two(BA, C),
    BC = merge_two(B, C),
    BCA = merge_two(BC, A),
    CA = merge_two(C, A),
    CAB = merge_two(CA, B),
    CB = merge_two(C, B),
    CBA = merge_two(CB, A),
    lists:min([ABC, ACB, BAC, BCA, CAB, CBA]).

merge_two(S1, S2) ->
    if
        length(S1) >= length(S2), string:str(S1, S2) > 0 ->
            S1;
        true ->
            MaxOverlap = min(length(S1), length(S2)),
            Overlap = lists:foldl(fun(I, Acc) ->
                case string:slice(S1, -(I), I) == string:slice(S2, 0, I) of
                    true -> I;
                    false -> Acc
                end
            end, 0, lists:seq(1, MaxOverlap)),
            if
                Overlap > 0 ->
                    S1 ++ string:slice(S2, Overlap);
                true ->
                    S1 ++ S2
            end
    end.

permutations([]) -> [];
permutations([X]) -> [[X]];
permutations(L) ->
    [[H|T] || H <- L, T <- permutations(L -- [H])].