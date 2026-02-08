-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    case lists:member(1, Nums) of
        true -> length(Nums) - 1;
        false ->
            case find_min_gcd(Nums) of
                {ok, Steps} -> Steps + length(Nums) - 1;
                error -> -1
            end
    end.

find_min_gcd(Nums) ->
    find_min_gcd(Nums, length(Nums), maps:new(), 0).

find_min_gcd([], _, _, _) ->
    error;
find_min_gcd([Num | Rest], Len, GcdMap, Steps) ->
    NewGcdMap = maps:new(),
    NewGcdMap1 = update_gcd_map(Num, GcdMap, NewGcdMap, Steps + 1),
    case maps:fold(fun
        (1, _, _) -> {ok, Steps + 1};
        (Gcd, S, Acc) ->
            case Acc of
                {ok, _} -> Acc;
                error -> {ok, S + Len - 1}
            end
        end, error, NewGcdMap1) of
        {ok, TotalSteps} -> {ok, TotalSteps};
        error -> find_min_gcd(Rest, Len, NewGcdMap1, Steps + 1)
    end.

update_gcd_map(CurrentNum, OldGcdMap, NewGcdMap, Steps) ->
    maps:put(CurrentNum, Steps, NewGcdMap),
    maps:fold(fun(Gcd, S, Acc) ->
        NewGcd = gcd(Gcd, CurrentNum),
        case maps:is_key(NewGcd, Acc) of
            true -> Acc;
            false -> maps:put(NewGcd, S + 1, Acc)
        end
    end, NewGcdMap, OldGcdMap).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).