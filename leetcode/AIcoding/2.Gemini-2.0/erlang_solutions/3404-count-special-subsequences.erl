-module(count_special_subsequences).
-export([count_special_subsequences/1]).

count_special_subsequences(Nums) ->
    Mod = 1000000007,
    {Zeros, Ones, Twos} = lists:foldl(
        fun(Num, {Z, O, T}) ->
            case Num of
                0 -> {((2 * Z) rem Mod + 1) rem Mod, O, T};
                1 -> {Z, ((2 * O) rem Mod + Z) rem Mod, T};
                2 -> {Z, O, ((2 * T) rem Mod + O) rem Mod}
            end
        end,
        {0, 0, 0},
        Nums
    ),
    Twos.