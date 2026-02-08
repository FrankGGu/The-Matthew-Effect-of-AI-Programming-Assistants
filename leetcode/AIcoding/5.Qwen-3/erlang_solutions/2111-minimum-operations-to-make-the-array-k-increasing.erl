-module(min_operations).
-export([minOperations/2]).

minOperations(A, K) ->
    N = length(A),
    lists:foldl(fun(I, Acc) ->
        if I rem K == 0 ->
            Index = I div K,
            Sub = lists:sublist(A, Index * K + 1, K),
            L = length(Sub),
            LIS = longest_increasing_subsequence(Sub),
            Acc + (L - LIS);
        true ->
            Acc
        end
    end, 0, lists:seq(1, N)).

longest_increasing_subsequence(List) ->
    longest_increasing_subsequence(List, []).

longest_increasing_subsequence([], Acc) ->
    length(Acc);
longest_increasing_subsequence([H | T], Acc) ->
    case lists:member(H, Acc) of
        true ->
            longest_increasing_subsequence(T, Acc);
        false ->
            case Acc of
                [] ->
                    longest_increasing_subsequence(T, [H]);
                _ ->
                    case H >= lists:last(Acc) of
                        true ->
                            longest_increasing_subsequence(T, Acc ++ [H]);
                        false ->
                            InsertPos = find_insert_position(Acc, H),
                            NewAcc = lists:sublist(Acc, InsertPos) ++ [H] ++ lists:sublist(Acc, InsertPos + 1, length(Acc) - InsertPos),
                            longest_increasing_subsequence(T, NewAcc)
                    end
            end
    end.

find_insert_position(List, X) ->
    find_insert_position(List, X, 1).

find_insert_position([], _, Pos) ->
    Pos;
find_insert_position([H | T], X, Pos) ->
    if H >= X ->
        Pos;
    true ->
        find_insert_position(T, X, Pos + 1)
    end.