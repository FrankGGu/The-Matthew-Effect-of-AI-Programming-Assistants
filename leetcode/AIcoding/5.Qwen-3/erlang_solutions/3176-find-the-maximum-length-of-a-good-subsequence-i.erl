-module(solution).
-export([max_gcd_subsequence/2]).

max_gcd_subsequence(A, B) ->
    Max = 0,
    N = length(A),
    M = length(B),
    GCDs = lists:seq(1, 1000),
    lists:foldl(fun(G, Acc) ->
        AIndices = lists:foldl(fun(I, Acc2) ->
            case lists:member(G, [math:gcd(A,I) || I <- A]) of
                true -> [I | Acc2];
                false -> Acc2
            end
        end, [], lists:seq(0, N-1)),
        BIndices = lists:foldl(fun(I, Acc2) ->
            case lists:member(G, [math:gcd(B,I) || I <- B]) of
                true -> [I | Acc2];
                false -> Acc2
            end
        end, [], lists:seq(0, M-1)),
        Count = count_common(AIndices, BIndices),
        if Count > Acc -> Count;
           true -> Acc
        end
    end, Max, GCDs).

count_common([], _) -> 0;
count_common(_, []) -> 0;
count_common([H|T], List) ->
    case lists:member(H, List) of
        true -> 1 + count_common(T, List);
        false -> count_common(T, List)
    end.