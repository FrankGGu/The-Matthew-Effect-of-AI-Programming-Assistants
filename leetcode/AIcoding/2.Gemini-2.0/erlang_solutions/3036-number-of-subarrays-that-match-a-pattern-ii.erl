-module(subarray_match_pattern_ii).
-export([number_of_match_subarray/2]).

number_of_match_subarray(Nums, Pattern) ->
    number_of_match_subarray(Nums, Pattern, 0).

number_of_match_subarray(Nums, Pattern, Acc) ->
    Len_n = length(Nums),
    Len_p = length(Pattern),
    if Len_n < Len_p + 1 then
        Acc
    else
        Subarray = lists:sublist(Nums, 1, Len_p + 1),
        if match_pattern(Subarray, Pattern) then
            number_of_match_subarray(tl(Nums), Pattern, Acc + 1)
        else
            number_of_match_subarray(tl(Nums), Pattern, Acc)
        end
    end.

match_pattern(Nums, Pattern) ->
    match_pattern(Nums, Pattern, 1).

match_pattern([_], [], _) ->
    true;
match_pattern([H1, H2 | T], [PH | PT], Index) ->
    case compare(H1, H2) of
        -1 ->
            if PH =:= 0 then
                match_pattern([H2 | T], PT, Index + 1)
            else
                false
            end;
        0 ->
            if PH =:= 1 then
                match_pattern([H2 | T], PT, Index + 1)
            else
                false
            end;
        1 ->
            if PH =:= 2 then
                match_pattern([H2 | T], PT, Index + 1)
            else
                false
            end
    end;
match_pattern(_, _, _) ->
    false.

compare(A, B) ->
    if A < B then
        -1
    else if A > B then
        1
    else
        0
    end.