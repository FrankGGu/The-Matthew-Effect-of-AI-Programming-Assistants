-spec max_count(M :: integer(), N :: integer(), Ops :: [[integer()]]) -> integer().
max_count(M, N, Ops) ->
    {MinRow, MinCol} = lists:foldl(
        fun([R, C], {CurrentMinR, CurrentMinC}) ->
            {min(CurrentMinR, R), min(CurrentMinC, C)}
        end,
        {M, N},
        Ops
    ),
    MinRow * MinCol.