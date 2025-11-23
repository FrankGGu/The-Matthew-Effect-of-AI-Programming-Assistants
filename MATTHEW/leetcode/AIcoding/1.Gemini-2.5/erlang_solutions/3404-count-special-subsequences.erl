-module(solution).
-export([countSpecialSubsequences/1]).

countSpecialSubsequences(S) ->
    Mod = 1000000007,
    {_DP0, _DP1, DP2} = lists:foldl(
        fun(Char, {DP0, DP1, DP2}) ->
            case Char of
                $0 ->
                    NewDP0 = (2 * DP0 + 1) rem Mod,
                    {NewDP0, DP1, DP2};
                $1 ->
                    NewDP1 = (2 * DP1 + DP0) rem Mod,
                    {DP0, NewDP1, DP2};
                $2 ->
                    NewDP2 = (2 * DP2 + DP1) rem Mod,
                    {DP0, DP1, NewDP2};
                _ ->
                    {DP0, DP1, DP2}
            end
        end,
        {0, 0, 0},
        S
    ),
    DP2.