-module(solution).
-export([findUniqueBinaryString/1]).

findUniqueBinaryString(Nums) ->
    N = length(hd(Nums)),
    NumsSet = sets:from_list(Nums),
    find_unique_string_recursive(0, N, NumsSet).

find_unique_string_recursive(CurrentNum, N, NumsSet) ->
    BinaryString = int_to_padded_binary_string(CurrentNum, N),
    case sets:is_element(BinaryString, NumsSet) of
        true ->
            find_unique_string_recursive(CurrentNum + 1, N, NumsSet);
        false ->
            BinaryString
    end.

int_to_padded_binary_string(Int, N) ->
    BinStr = integer_to_list(Int, 2),
    PadLen = N - length(BinStr),
    if PadLen > 0 -> lists:duplicate(PadLen, $0) ++ BinStr;
       true -> BinStr
    end.