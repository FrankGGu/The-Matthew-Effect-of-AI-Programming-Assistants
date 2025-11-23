-module(solution).
-export([minimum_string/1]).

minimum_string([A, B, C]) ->
    All = [A, B, C],
    Perms = permutations(All),
    lists:foldl(fun(P, Min) ->
        Merged = merge_all(P),
        case string:length(Merged) < string:length(Min) of
            true -> Merged;
            false -> Min
        end
    end, lists:concat([A, B, C]), Perms).

permutations([]) -> [[]];
permutations(L) -> [[H|T] || H <- L, T <- permutations(L -- [H])].

merge_all([S1, S2, S3]) ->
    merge(merge(S1, S2), S3).

merge(A, B) ->
    case string:str(A, B) of
        1 -> A;
        _ ->
            case find_overlap(A, B) of
                0 -> A ++ B;
                N -> string:substr(A, 1, length(A) - N) ++ B
            end
    end.

find_overlap(A, B) ->
    LenA = length(A),
    LenB = length(B),
    MaxOverlap = min(LenA, LenB),
    find_overlap(A, B, MaxOverlap).

find_overlap(_, _, 0) -> 0;
find_overlap(A, B, K) ->
    Suffix = string:substr(A, length(A) - K + 1, K),
    Prefix = string:substr(B, 1, K),
    case Suffix == Prefix of
        true -> K;
        false -> find_overlap(A, B, K - 1)
    end.