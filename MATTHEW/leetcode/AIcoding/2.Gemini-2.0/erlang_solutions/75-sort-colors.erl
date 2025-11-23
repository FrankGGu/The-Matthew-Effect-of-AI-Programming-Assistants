-module(sort_colors).
-export([sort_colors/1]).

sort_colors(Nums) ->
    {Zeros, Ones, Twos} = lists:foldl(
        fun(Num, {Z, O, T}) ->
            case Num of
                0 -> {Z + 1, O, T};
                1 -> {Z, O + 1, T};
                2 -> {Z, O, T + 1}
            end
        end, {0, 0, 0}, Nums
    ),
    lists:concat([lists:seq(1, Zeros, 1) ++ lists:seq(1, Ones, 1) ++ lists:seq(1, Twos, 1)],
    fun(I) ->
        case I of
            1 -> 0;
            _ -> 1
        end
    end).