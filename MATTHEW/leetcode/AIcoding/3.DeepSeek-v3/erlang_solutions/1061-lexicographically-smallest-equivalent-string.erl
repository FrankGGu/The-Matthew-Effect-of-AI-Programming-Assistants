-spec smallest_equivalent_string(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary(), BaseStr :: unicode:unicode_binary()) -> unicode:unicode_binary().
smallest_equivalent_string(S1, S2, BaseStr) ->
    Parent = maps:new(),
    {Parent1, _} = lists:foldl(fun({A, B}, {P, _}) -> union(A, B, P) end, {Parent, 0}, lists:zip(binary_to_list(S1), binary_to_list(S2))),
    Result = lists:map(fun(C) -> find(C, Parent1) end, binary_to_list(BaseStr)),
    list_to_binary(Result).

find(C, Parent) ->
    case maps:get(C, Parent, undefined) of
        undefined -> C;
        P when P < C -> find(P, Parent);
        _ -> C
    end.

union(A, B, Parent) ->
    RootA = find(A, Parent),
    RootB = find(B, Parent),
    if
        RootA < RootB -> {maps:put(RootB, RootA, Parent), 0};
        RootB < RootA -> {maps:put(RootA, RootB, Parent), 0};
        true -> {Parent, 0}
    end.