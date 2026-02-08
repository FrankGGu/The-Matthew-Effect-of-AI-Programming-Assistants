-spec is_valid_serialization(Preorder :: unicode:unicode_binary()) -> boolean().
is_valid_serialization(Preorder) ->
    Nodes = string:split(Preorder, ",", all),
    check(Nodes, 0).

check([], Slots) ->
    Slots == 0;
check([Node | Rest], Slots) when Slots < 0 ->
    false;
check(["#" | Rest], Slots) ->
    check(Rest, Slots - 1);
check([_ | Rest], Slots) ->
    check(Rest, Slots + 1).