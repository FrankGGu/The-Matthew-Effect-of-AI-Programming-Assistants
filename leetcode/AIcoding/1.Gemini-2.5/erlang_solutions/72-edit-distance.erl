-module(solution).
-export([minDistance/2]).

minDistance(Word1, Word2) ->
    Len1 = length(Word1),
    Len2 = length(Word2),

    Word1Arr = array:from_list(Word1),
    Word2Arr = array:from_list(Word2),

    PrevRow = array:new([{size, Len2 + 1}, {fixed, true}]),
    PrevRowFilled = lists:foldl(fun(J, Acc) -> array:set(J, J, Acc) end, PrevRow, lists:seq(0, Len2)),

    FinalRow = lists:foldl(fun(I, CurrentPrevRow) ->
        CurrentRow = array:new([{size, Len2 + 1}, {fixed, true}]),
        CurrentRow1 = array:set(0, I, CurrentRow),

        Word1Char = array:get(I-1, Word1Arr),

        CurrentRowFilled = lists:foldl(fun(J, AccRow) ->
            Word2Char = array:get(J-1, Word2Arr),

            Val = if Word1Char == Word2Char ->
                      array:get(J-1, CurrentPrevRow);
                  else
                      Replace = array:get(J-1, CurrentPrevRow),
                      Delete  = array:get(J, CurrentPrevRow),
                      Insert  = array:get(J-1, AccRow),
                      1 + min(Replace, min(Delete, Insert))
                  end,
            array:set(J, Val, AccRow)
        end, CurrentRow1, lists:seq(1, Len2)),
        CurrentRowFilled
    end, PrevRowFilled, lists:seq(1, Len1)),

    array:get(Len2, FinalRow).