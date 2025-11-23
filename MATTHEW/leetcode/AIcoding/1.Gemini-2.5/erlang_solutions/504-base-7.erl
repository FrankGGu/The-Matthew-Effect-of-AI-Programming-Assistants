-spec convert_to_base7(Num :: integer()) -> unicode:chardata().
convert_to_base7(0) ->
    "0";
convert_to_base7(Num) when Num < 0 ->
    "-" ++ convert_to_base7_positive(abs(Num));
convert_to_base7(Num) ->
    convert_to_base7_positive(Num).

convert_to_base7_positive(0) ->
    "";
convert_to_base7_positive(Num) ->
    Digit = Num rem 7,
    Remainder = Num div 7,
    convert_to_base7_positive(Remainder) ++ integer_to_list(Digit).