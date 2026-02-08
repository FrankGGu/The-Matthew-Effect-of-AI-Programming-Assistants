-module(solution).
-export([minimumOperations/1]).

minimumOperations(Leaves) ->
    N = length(Leaves),
    Infinity = N + 1,

    Char0 = hd(Leaves),
    C0_init = if Char0 == $y -> 1;
                 true -> 0
              end,

    C1_init = Infinity,
    C2_init = Infinity,

    {_FinalC0, _FinalC1, FinalC2} = lists:foldl(
        fun(Char, {C0, C1, C2}) ->
            Cost_to_be_r = if Char == $y -> 1;
                             true -> 0
                           end,
            Cost_to_be_y = if Char == $r -> 1;
                             true -> 0
                           end,

            NewC0 = C0 + Cost_to_be_r,
            NewC1 = min(C0, C1) + Cost_to_be_y,
            NewC2 = min(C1, C2) + Cost_to_be_r,

            {NewC0, NewC1, NewC2}
        end,
        {C0_init, C1_init, C2_init},
        tl(Leaves)
    ),
    FinalC2.