-module(negabinary_add).
-export([addNegabinary/2]).

addNegabinary(Arr1, Arr2) ->
    addNegabinary(Arr1, Arr2, 0, []).

addNegabinary([], [], Carry, Acc) ->
    addNegabinary([Carry], [], 0, Acc);
addNegabinary([], Arr, Carry, Acc) ->
    addNegabinary([0], Arr, Carry, Acc);
addNegabinary(Arr, [], Carry, Acc) ->
    addNegabinary(Arr, [0], Carry, Acc);
addNegabinary([H1|T1], [H2|T2], Carry, Acc) ->
    Sum = H1 + H2 + Carry,
    case Sum of
        -2 ->
            addNegabinary(T1, T2, 1, [0|Acc]);
        -1 ->
            addNegabinary(T1, T2, 1, [1|Acc]);
        0 ->
            addNegabinary(T1, T2, 0, [0|Acc]);
        1 ->
            addNegabinary(T1, T2, -1, [1|Acc]);
        2 ->
            addNegabinary(T1, T2, -1, [0|Acc]);
        _ ->
            error("Invalid sum")
    end.

addNegabinary([], [], 0, Acc) ->
    removeLeadingZeros(lists:reverse(Acc));
addNegabinary([H|T], [], 0, Acc) ->
    addNegabinary(T, [], 0, [H|Acc]);
addNegabinary([], [H|T], 0, Acc) ->
    addNegabinary([], T, 0, [H|Acc]).

removeLeadingZeros(List) ->
    removeLeadingZerosHelper(List, []).

removeLeadingZerosHelper([], Acc) ->
    case Acc of
        [] -> [0];
        _ -> lists:reverse(Acc)
    end;
removeLeadingZerosHelper([0|T], []) ->
    removeLeadingZerosHelper(T, []);
removeLeadingZerosHelper([H|T], Acc) ->
    removeLeadingZerosHelper(T, [H|Acc]).