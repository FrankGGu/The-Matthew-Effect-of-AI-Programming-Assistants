-module(solution).
-export([longest_pressed_time/1]).

longest_pressed_time(Buttons) ->
    {Max, Current, _} = lists:foldl(fun
        (Button, {MaxAcc, CurrentAcc, Prev}) when Button =:= Prev ->
            NewCurrent = CurrentAcc + 1,
            {max(MaxAcc, NewCurrent), NewCurrent, Button};
        (Button, {MaxAcc, _, _}) ->
            {max(MaxAcc, 1), 1, Button}
    end, {0, 0, undefined}, Buttons),
    Max.