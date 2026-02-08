-module(range_addition_ii).
-export([max_count/1]).

max_count(Ops) ->
    case Ops of
        [] -> 1;
        _ ->
            {MinA, MinB} = lists:foldl(
                fun([A, B], {CurrentMinA, CurrentMinB}) ->
                    {min(A, CurrentMinA), min(B, CurrentMinB)}
                end,
                {infinity, infinity},
                Ops
            ),
            MinA * MinB
    end.