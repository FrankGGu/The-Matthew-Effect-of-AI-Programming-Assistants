-module(solution).
-export([countSpecialSubsequences/1]).

countSpecialSubsequences(Nums) ->
    Mod = 1000000007,
    {_Dp0, _Dp1, Dp2} = lists:foldl(
        fun(Num, {CurrentDp0, CurrentDp1, CurrentDp2}) ->
            case Num of
                0 ->
                    NewDp0 = (2 * CurrentDp0 + 1) rem Mod,
                    {NewDp0, CurrentDp1, CurrentDp2};
                1 ->
                    NewDp1 = (2 * CurrentDp1 + CurrentDp0) rem Mod,
                    {CurrentDp0, NewDp1, CurrentDp2};
                2 ->
                    NewDp2 = (2 * CurrentDp2 + CurrentDp1) rem Mod,
                    {CurrentDp0, CurrentDp1, NewDp2};
                _ ->
                    {CurrentDp0, CurrentDp1, CurrentDp2}
            end
        end,
        {0, 0, 0},
        Nums
    ),
    Dp2.