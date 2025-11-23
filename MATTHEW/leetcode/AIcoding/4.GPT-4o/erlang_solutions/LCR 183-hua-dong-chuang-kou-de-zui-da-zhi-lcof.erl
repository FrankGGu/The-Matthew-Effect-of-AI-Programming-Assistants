-module(solution).
-export([max_height/1]).

max_height(Heights) ->
    lists:foldl(fun (H, {Max, Current}) ->
        NewCurrent = max(Current + H, H),
        {max(Max, NewCurrent), NewCurrent}
    end, {hd(Heights), hd(Heights)}, tl(Heights)) |> elem(0).