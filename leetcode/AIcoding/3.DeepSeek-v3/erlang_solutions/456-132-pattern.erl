-spec find132pattern(Nums :: [integer()]) -> boolean().
find132pattern(Nums) ->
    case Nums of
        [] -> false;
        _ ->
            Stack = [],
            Third = -1000000001,
            find132pattern(lists:reverse(Nums), Stack, Third)
    end.

find132pattern([], _Stack, Third) ->
    Third > -1000000001;
find132pattern([Num | Rest], Stack, Third) ->
    if
        Num < Third -> true;
        true ->
            NewStack = update_stack(Stack, Num),
            find132pattern(Rest, NewStack, Third)
    end.

update_stack([], Num) ->
    [Num];
update_stack([Top | Rest], Num) when Num > Top ->
    update_stack(Rest, Num);
update_stack(Stack, Num) ->
    [Num | Stack].