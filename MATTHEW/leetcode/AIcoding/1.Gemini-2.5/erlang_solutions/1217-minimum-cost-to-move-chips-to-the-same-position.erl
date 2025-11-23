-module(solution).
-export([min_cost_to_move_chips/1]).

min_cost_to_move_chips(Chips) ->
    {EvenCount, OddCount} = lists:foldl(
        fun(ChipPos, {AccEven, AccOdd}) ->
            if
                ChipPos rem 2 == 0 -> {AccEven + 1, AccOdd};
                true -> {AccEven, AccOdd + 1}
            end
        end,
        {0, 0},
        Chips
    ),
    min(EvenCount, OddCount).