-module(solution).
-export([min_distance/2]).

min_distance(Word1, Word2) ->
    Len1 = byte_size(Word1),
    Len2 = byte_size(Word2),

    case Len1 > Len2 of
        true -> min_distance(Word2, Word1);
        false ->
            PrevRow = array:new([{size, Len2 + 1}, {default, 0}]),
            LCS = calculate_lcs(1, Len1, Len2, Word1, Word2, PrevRow),
            Len1 + Len2 - 2 * LCS
    end.

calculate_lcs(I, MaxI, MaxJ, Word1, Word2, PrevRow) when I =< MaxI ->
    CurrentRow = array:new([{size, MaxJ + 1}, {default, 0}]),

    UpdatedCurrentRow = lists:foldl(fun(J, AccCurrentRow) ->
                                        Char1 = binary:at(Word1, I - 1),
                                        Char2 = binary:at(Word2, J - 1),
                                        Val = if
                                                Char1 == Char2 ->
                                                  array:get(J - 1, PrevRow) + 1;
                                                true ->
                                                  max(array:get(J, PrevRow), array:get(J - 1, AccCurrentRow))
                                              end,
                                        array:set(J, Val, AccCurrentRow)
                                    end, CurrentRow, lists:seq(1, MaxJ)),
    calculate_lcs(I + 1, MaxI, MaxJ, Word1, Word2, UpdatedCurrentRow);
calculate_lcs(_I, _MaxI, MaxJ, _Word1, _Word2, PrevRow) ->
    array:get(MaxJ, PrevRow).