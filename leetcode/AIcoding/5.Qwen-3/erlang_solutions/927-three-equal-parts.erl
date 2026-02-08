-module(three_equal_parts).
-export([three_equal_parts/1]).

three_equal_parts(Bits) ->
    N = length(Bits),
    Ones = lists:foldl(fun(X, Acc) -> Acc + X end, 0, Bits),
    case Ones rem 3 of
        0 ->
            case Ones of
                0 -> [0, 1, 2];
                _ ->
                    K = Ones div 3,
                    I = find_index(Bits, 1, 0, K),
                    J = find_index(Bits, 1, I + 1, K),
                    L = find_index(Bits, 1, J + 1, K),
                    if
                        L == -1 -> [-1, -1, -1];
                        true ->
                            E1 = I + N - 1 - count_trailing_zeros(Bits, L),
                            E2 = J + N - 1 - count_trailing_zeros(Bits, L),
                            E3 = L + N - 1 - count_trailing_zeros(Bits, L),
                            if
                                E1 >= J -> [-1, -1, -1];
                                E2 >= L -> [-1, -1, -1];
                                true -> [I, J, L]
                            end
                    end
            end;
        _ -> [-1, -1, -1]
    end.

find_index(Bits, Val, Start, Count) ->
    find_index(Bits, Val, Start, Count, 0).

find_index([], _, _, _, _) -> -1;
find_index([H | T], Val, Start, Count, Index) ->
    if
        Index < Start -> find_index(T, Val, Start, Count, Index + 1);
        H == Val ->
            case Count of
                1 -> Index;
                _ -> find_index(T, Val, Start, Count - 1, Index + 1)
            end;
        true -> find_index(T, Val, Start, Count, Index + 1)
    end.

count_trailing_zeros([], _) -> 0;
count_trailing_zeros([0 | T], Count) -> count_trailing_zeros(T, Count + 1);
count_trailing_zeros(_, Count) -> Count.