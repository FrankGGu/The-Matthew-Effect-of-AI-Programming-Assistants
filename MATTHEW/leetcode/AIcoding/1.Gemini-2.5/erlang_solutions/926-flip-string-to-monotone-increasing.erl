-module(solution).
-export([min_flips_mono_incr/1]).

min_flips_mono_incr(S) ->
    {F0, F1} = lists:foldl(
        fun(Char, {CurrentF0, CurrentF1}) ->
            case Char of
                $0 ->
                    NewF0 = CurrentF0,
                    NewF1 = min(CurrentF0, CurrentF1) + 1,
                    {NewF0, NewF1};
                $1 ->
                    NewF0 = CurrentF0 + 1,
                    NewF1 = min(CurrentF0, CurrentF1),
                    {NewF0, NewF1}
            end
        end,
        {0, 0},
        S
    ),
    min(F0, F1).