-module(solution).
-export([longest_mountain/1]).

longest_mountain(Arr) ->
    Len = length(Arr),
    if Len < 3 ->
        0;
    true ->
        {MaxLen, _, _, _} = lists:foldl(
            fun(CurrentVal, {AccMaxLen, PrevVal, Up, Down}) ->
                {NewUp, NewDown} =
                    if CurrentVal > PrevVal ->
                        if Down > 0 ->
                            {1, 0};
                        else ->
                            {Up + 1, 0}
                        end;
                    CurrentVal < PrevVal ->
                        if Up > 0 ->
                            {Up, Down + 1};
                        else ->
                            {0, 0}
                        end;
                    true ->
                        {0, 0}
                    end,

                CurrentMountainLen =
                    if NewUp > 0 andalso NewDown > 0 ->
                        NewUp + NewDown + 1;
                    true ->
                        0
                    end,

                {max(AccMaxLen, CurrentMountainLen), CurrentVal, NewUp, NewDown}
            end,
            {0, hd(Arr), 0, 0},
            tl(Arr)
        ),
        MaxLen
    end.