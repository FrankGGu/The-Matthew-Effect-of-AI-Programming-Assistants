-module(solution).
-export([num_decodings/1]).

-define(MOD, 1000000007).

ways_one($0) -> 0;
ways_one($*) -> 9;
ways_one(_)  -> 1.

ways_two(C1, C2) ->
    case {C1, C2} of
        {$1, $*} -> 9;
        {$1, _}  -> 1;
        {$2, $*} -> 6;
        {$2, C2_Val} when C2_Val >= $0 andalso C2_Val <= $6 -> 1;
        {$*, $*} -> 15;
        {$*, C2_Val} when C2_Val >= $0 andalso C2_Val <= $6 -> 2;
        {$*, C2_Val} when C2_Val >= $7 andalso C2_Val <= $9 -> 1;
        _        -> 0
    end.

num_decodings(S) ->
    N = length(S),
    case N of
        0 -> 1;
        1 -> ways_one(hd(S));
        _ ->
            Dp_prev2 = 1,
            Dp_prev1 = ways_one(hd(S)),

            lists:foldl(
                fun(CurrentChar, {Acc_dp_prev1, Acc_dp_prev2, PrevChar}) ->
                    Ways1 = (Acc_dp_prev1 * ways_one(CurrentChar)) rem ?MOD,
                    Ways2 = (Acc_dp_prev2 * ways_two(PrevChar, CurrentChar)) rem ?MOD,

                    Dp_current = (Ways1 + Ways2) rem ?MOD,

                    {Dp_current, Acc_dp_prev1, CurrentChar}
                end,
                {Dp_prev1, Dp_prev2, hd(S)},
                tl(S)
            )
            of {Result, _, _} -> Result
    end.