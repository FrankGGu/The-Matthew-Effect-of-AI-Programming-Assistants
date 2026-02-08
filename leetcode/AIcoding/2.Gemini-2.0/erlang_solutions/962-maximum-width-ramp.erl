-module(maximum_width_ramp).
-export([max_width_ramp/1]).

max_width_ramp(A) ->
    max_width_ramp(A, 0, length(A) - 1).

max_width_ramp(A, I, J) ->
    max_width_ramp_helper(A, I, J, 0).

max_width_ramp_helper(A, I, J, MaxWidth) ->
    if
        I >= J ->
            MaxWidth;
        true ->
            if
                lists:nth(I + 1, A) =< lists:nth(J + 1, A) ->
                    max_width_ramp_helper(A, I + 1, J - 1, max(MaxWidth, J - I));
                true ->
                    NewMaxWidth1 = max_width_ramp_helper(A, I + 1, J, MaxWidth),
                    NewMaxWidth2 = max_width_ramp_helper(A, I, J - 1, MaxWidth),
                    max(NewMaxWidth1, NewMaxWidth2)
            end
    end.