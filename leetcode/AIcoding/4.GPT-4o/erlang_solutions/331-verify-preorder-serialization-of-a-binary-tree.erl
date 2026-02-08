-spec is_valid_serialization(Preorder :: unicode:unicode_binary()) -> boolean().
is_valid_serialization(Preorder) ->
    is_valid_serialization(string:split(Preorder, ","), 1).

is_valid_serialization([], 0) -> true;
is_valid_serialization([], _) -> false;
is_valid_serialization([#"\#" | Rest], Slots) -> is_valid_serialization(Rest, Slots - 1);
is_valid_serialization([_ | Rest], Slots) when Slots > 0 -> 
    is_valid_serialization(Rest, Slots + 1);
is_valid_serialization(_, _) -> false.
