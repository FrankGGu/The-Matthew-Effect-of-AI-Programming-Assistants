-module(solution).
-export([minimum_number/1]).

minimum_number(N) ->
    Digits = integer_to_list(N),
    SortDigits(Digits, 0).

SortDigits(Digits, Pos) when Pos == length(Digits) ->
    list_to_integer(Digits);
SortDigits(Digits, Pos) ->
    MinIndex = find_min_index(Digits, Pos),
    {MinChar, Rest} = split_at(MinIndex, Digits),
    NewDigits = [MinChar | Rest],
    case Pos of
        0 ->
            if
                MinChar == $0 -> 
                    % Find the first non-zero digit to swap with the first position
                    FirstNonZero = find_first_non_zero(NewDigits, 0),
                    SwapPositions(NewDigits, 0, FirstNonZero);
                true ->
                    NewDigits
            end;
        _ ->
            NewDigits
    end.

find_min_index([], _) -> 0;
find_min_index(Digits, Pos) ->
    MinChar = lists:nth(Pos + 1, Digits),
    MinIndex = Pos,
    find_min_index(Digits, Pos, MinChar, MinIndex).

find_min_index([], _, _, MinIndex) -> MinIndex;
find_min_index([H|T], Pos, MinChar, MinIndex) ->
    if
        H < MinChar ->
            find_min_index(T, Pos + 1, H, Pos + 1);
        true ->
            find_min_index(T, Pos + 1, MinChar, MinIndex)
    end.

split_at(0, L) -> {[], L};
split_at(N, [H|T]) ->
    {L1, L2} = split_at(N - 1, T),
    {[H|L1], L2}.

find_first_non_zero([], _) -> 0;
find_first_non_zero([H|T], Pos) ->
    if
        H /= $0 -> Pos;
        true -> find_first_non_zero(T, Pos + 1)
    end.

SwapPositions(L, I, J) ->
    A = lists:sublist(L, I + 1),
    B = lists:sublist(L, J + 1, 1),
    C = lists:sublist(L, J + 1),
    D = lists:sublist(L, J + 1),
    E = lists:sublist(L, J + 1),
    F = lists:sublist(L, J + 1),
    G = lists:sublist(L, J + 1),
    H = lists:sublist(L, J + 1),
    I = lists:sublist(L, J + 1),
    J = lists:sublist(L, J + 1),
    K = lists:sublist(L, J + 1),
    L = lists:sublist(L, J + 1),
    M = lists:sublist(L, J + 1),
    N = lists:sublist(L, J + 1),
    O = lists:sublist(L, J + 1),
    P = lists:sublist(L, J + 1),
    Q = lists:sublist(L, J + 1),
    R = lists:sublist(L, J + 1),
    S = lists:sublist(L, J + 1),
    T = lists:sublist(L, J + 1),
    U = lists:sublist(L, J + 1),
    V = lists:sublist(L, J + 1),
    W = lists:sublist(L, J + 1),
    X = lists:sublist(L, J + 1),
    Y = lists:sublist(L, J + 1),
    Z = lists:sublist(L, J + 1),
    lists:append(A, [lists:nth(J + 1, L)] ++ lists:sublist(L, I + 2, J - I - 1) ++ [lists:nth(I + 1, L)] ++ lists:sublist(L, J + 2)).