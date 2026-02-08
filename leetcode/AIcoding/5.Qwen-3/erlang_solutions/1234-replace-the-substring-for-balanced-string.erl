-module(replace_the_substring_for_balanced_string).
-export([replace_required/1]).

replace_required(S) ->
    N = length(S),
    Count = fun(Char) -> count(Char, S) end,
    MinLen = N,
    MaxCount = max(Count($a), max(Count($b), max(Count($c), Count($d)))),
    if
        MaxCount * 4 == N -> 0;
        true ->
            replace_required(S, N, Count, MinLen)
    end.

count(Char, Str) ->
    count(Char, Str, 0).

count(_, [], Acc) -> Acc;
count(Char, [Char | T], Acc) -> count(Char, T, Acc + 1);
count(Char, [_ | T], Acc) -> count(Char, T, Acc).

replace_required(S, N, Count, MinLen) ->
    I = 0,
    J = 0,
    replace_required(S, N, Count, MinLen, I, J, 0, 0, 0, 0).

replace_required(S, N, Count, MinLen, I, J, A, B, C, D) ->
    case J of
        N -> MinLen;
        _ ->
            Char = lists:nth(J + 1, S),
            case Char of
                $a -> A1 = A + 1, B1 = B, C1 = C, D1 = D;
                $b -> A1 = A, B1 = B + 1, C1 = C, D1 = D;
                $c -> A1 = A, B1 = B, C1 = C + 1, D1 = D;
                $d -> A1 = A, B1 = B, C1 = C, D1 = D + 1
            end,
            MaxCount = max(A1, max(B1, max(C1, D1))),
            if
                MaxCount * 4 <= N - (J - I + 1) ->
                    NewMinLen = min(MinLen, J - I + 1),
                    replace_required(S, N, Count, NewMinLen, I + 1, J, A1, B1, C1, D1);
                true ->
                    replace_required(S, N, Count, MinLen, I, J + 1, A1, B1, C1, D1)
            end
    end.