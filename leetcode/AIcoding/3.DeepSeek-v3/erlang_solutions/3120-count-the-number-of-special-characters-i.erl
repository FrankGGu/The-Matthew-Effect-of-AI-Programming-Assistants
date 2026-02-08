-spec count_special_numbers(Word :: unicode:unicode_binary()) -> integer().
count_special_numbers(Word) ->
    Bin = unicode:characters_to_binary(Word),
    Lower = sets:from_list([C || <<C>> <= Bin, C >= $a, C =< $z]),
    Upper = sets:from_list([C - $A + $a || <<C>> <= Bin, C >= $A, C =< $Z]),
    Common = sets:intersection(Lower, Upper),
    sets:size(Common).