-module(solution).
-export([getMaximumGenerated/1]).

getMaximumGenerated(0) -> 0;
getMaximumGenerated(N) when N > 0 ->
    InitialArray = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),

    ArrayWithBase = array:set(1, 1, InitialArray),

    MaxVal = 1,

    generate_and_find_max_recursive(1, N, ArrayWithBase, MaxVal).

generate_and_find_max_recursive(I, N, CurrentArray, CurrentMax) when 2*I =< N ->
    Val_I = array:get(I, CurrentArray),
    Val_2I = Val_I,
    Array_after_2I = array:set(2*I, Val_2I, CurrentArray),
    NewMax_after_2I = max(CurrentMax, Val_2I),

    if
        2*I + 1 =< N ->
            Val_I_plus_1 = array:get(I + 1, Array_after_2I),
            Val_2I_plus_1 = Val_I + Val_I_plus_1,
            Array_after_2I_plus_1 = array:set(2*I + 1, Val_2I_plus_1, Array_after_2I),
            NewMax_after_2I_plus_1 = max(NewMax_after_2I, Val_2I_plus_1),
            generate_and_find_max_recursive(I + 1, N, Array_after_2I_plus_1, NewMax_after_2I_plus_1);
        true ->
            generate_and_find_max_recursive(I + 1, N, Array_after_2I, NewMax_after_2I)
    end;
generate_and_find_max_recursive(_I, _N, _CurrentArray, CurrentMax) ->
    CurrentMax.