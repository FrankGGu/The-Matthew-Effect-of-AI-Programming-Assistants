-module(special_subsequences).
-export([count_special_subsequences/1]).

count_special_subsequences(Nums) ->
  Mod = 1000000007,
  foldl(
    fun(Num, {Zeros, Ones, Twos}) ->
      case Num of
        0 -> {((2 * Zeros) rem Mod + 1) rem Mod, Ones, Twos};
        1 -> {Zeros, ((2 * Ones) rem Mod + Zeros) rem Mod, Twos};
        2 -> {Zeros, Ones, ((2 * Twos) rem Mod + Ones) rem Mod}
      end
    end,
    {0, 0, 0},
    Nums
  ).

count_special_subsequences(Nums) ->
    Mod = 1000000007,
    {_, _, Twos} = foldl(
        fun(Num, {Zeros, Ones, Twos}) ->
            case Num of
                0 -> {((2 * Zeros) rem Mod + 1) rem Mod, Ones, Twos};
                1 -> {Zeros, ((2 * Ones) rem Mod + Zeros) rem Mod, Twos};
                2 -> {Zeros, Ones, ((2 * Twos) rem Mod + Ones) rem Mod}
            end
        end,
        {0, 0, 0},
        Nums
    ),
    Twos.