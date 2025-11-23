-module(solution).
-export([makeFancyString/1]).

makeFancyString(S) ->
    make_fancy_string(S, 0, 0, []).

make_fancy_string([], _, _, Acc) ->
    lists:reverse(Acc);
make_fancy_string([H | T], Count, Prev, Acc) ->
    NewCount = if H =:= Prev then Count + 1; true -> 1 end,
    NewPrev = H,
    if NewCount < 3 ->
        make_fancy_string(T, NewCount, NewPrev, [H | Acc]);
    true ->
        make_fancy_string(T, NewCount, NewPrev, Acc)
    end.