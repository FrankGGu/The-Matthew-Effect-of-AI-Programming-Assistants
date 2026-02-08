-module(solution).
-export([beautifulPairs/1]).

beautifulPairs(Nums) ->
    Len = length(Nums),
    count_pairs(Nums, Len, 0, 0).

count_pairs(_Nums, Len, I, Acc) when I >= Len - 1 ->
    Acc;
count_pairs(Nums, Len, I, Acc) ->
    NumI = lists:nth(I + 1, Nums),
    FirstD = first_digit(NumI),

    NewAcc = lists:foldl(
        fun(J, CurrentAcc) ->
            NumJ = lists:nth(J + 1, Nums),
            LastD = last_digit(NumJ),
            case is_coprime(FirstD, LastD) of
                true -> CurrentAcc + 1;
                false -> CurrentAcc
            end
        end,
        Acc,
        lists:seq(I + 1, Len - 1)
    ),
    count_pairs(Nums, Len, I + 1, NewAcc).

first_digit(N) when N < 10 -> N;
first_digit(N) -> first_digit(N div 10).

last_digit(N) -> N rem 10.

is_coprime(A, B) -> math:gcd(A, B) == 1.