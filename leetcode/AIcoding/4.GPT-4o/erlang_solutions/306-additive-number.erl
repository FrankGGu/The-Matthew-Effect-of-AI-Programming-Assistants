-spec is_additive_number(Num :: unicode:unicode_binary()) -> boolean().
is_additive_number(Num) ->
    is_additive_number(Num, 0, 0, 0, 0).

is_additive_number(_, _, _, _, _) -> false;  % Not enough numbers or invalid sequence
is_additive_number(Num, i, j, prev1, prev2) when i < j -> false; % We do not have enough digits
is_additive_number(Num, i, j, prev1, prev2) -> 
    case (string:substr(Num, i, j)) of
        <<X>> -> true;
        false ->  is_additive_number the
