-module(solution).
-export([number_of_unique_good_subsequences/1]).

number_of_unique_good_subsequences(Binary) ->
    MOD = 1000000007,
    Chars = string:to_list(Binary),

    {_A, B} = lists:foldl(
        fun(Char, {A_acc, B_acc}) ->
            case Char of
                $0 ->
                    New_A = (A_acc + B_acc) rem MOD,
                    {New_A, B_acc};
                $1 ->
                    New_B = (A_acc + B_acc + 1) rem MOD,
                    {A_acc, New_B}
            end
        end,
        {0, 0},
        Chars
    ),
    B.