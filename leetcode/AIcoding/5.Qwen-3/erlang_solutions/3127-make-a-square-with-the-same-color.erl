-module(solution).
-export([canMakeSquare/1]).

canMakeSquare(Board) ->
    canMakeSquare(Board, 0, 0).

canMakeSquare(_, _, 4) -> true;
canMakeSquare(_, 4, _) -> false;
canMakeSquare(Board, Row, Col) ->
    case check(Board, Row, Col) of
        true -> true;
        false -> 
            case canMakeSquare(Board, Row, Col + 1) of
                true -> true;
                _ -> canMakeSquare(Board, Row + 1, 0)
            end
    end.

check(Board, Row, Col) ->
    Size = length(Board),
    if
        Row + 3 >= Size; Col + 3 >= Size -> false;
        true ->
            C = lists:nth(Row + 1, Board),
            A = lists:nth(Col + 1, C),
            B = lists:nth(Col + 2, C),
            D = lists:nth(Col + 3, C),
            E = lists:nth(Row + 2, Board),
            F = lists:nth(Col + 1, E),
            G = lists:nth(Col + 2, E),
            H = lists:nth(Col + 3, E),
            I = lists:nth(Row + 3, Board),
            J = lists:nth(Col + 1, I),
            K = lists:nth(Col + 2, I),
            L = lists:nth(Col + 3, I),
            Count = countSameColor(A, B, D, F, G, H, J, K, L),
            Count >= 5
    end.

countSameColor(A, B, D, F, G, H, J, K, L) ->
    countSameColor(A, B, D, F, G, H, J, K, L, 0).

countSameColor(A, B, D, F, G, H, J, K, L, Acc) ->
    case Acc of
        5 -> 5;
        _ ->
            Count = Acc + 
                (if A == B -> 1; true -> 0 end) +
                (if A == D -> 1; true -> 0 end) +
                (if A == F -> 1; true -> 0 end) +
                (if A == G -> 1; true -> 0 end) +
                (if A == J -> 1; true -> 0 end) +
                (if A == K -> 1; true -> 0 end) +
                (if A == L -> 1; true -> 0 end) +
                (if B == D -> 1; true -> 0 end) +
                (if B == F -> 1; true -> 0 end) +
                (if B == G -> 1; true -> 0 end) +
                (if B == J -> 1; true -> 0 end) +
                (if B == K -> 1; true -> 0 end) +
                (if B == L -> 1; true -> 0 end) +
                (if D == F -> 1; true -> 0 end) +
                (if D == G -> 1; true -> 0 end) +
                (if D == J -> 1; true -> 0 end) +
                (if D == K -> 1; true -> 0 end) +
                (if D == L -> 1; true -> 0 end) +
                (if F == G -> 1; true -> 0 end) +
                (if F == J -> 1; true -> 0 end) +
                (if F == K -> 1; true -> 0 end) +
                (if F == L -> 1; true -> 0 end) +
                (if G == J -> 1; true -> 0 end) +
                (if G == K -> 1; true -> 0 end) +
                (if G == L -> 1; true -> 0 end) +
                (if J == K -> 1; true -> 0 end) +
                (if J == L -> 1; true -> 0 end) +
                (if K == L -> 1; true -> 0 end),
            countSameColor(A, B, D, F, G, H, J, K, L, Count)
    end.