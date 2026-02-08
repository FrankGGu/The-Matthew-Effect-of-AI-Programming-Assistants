-module(solution).
-export([largest_component_size/1]).

largest_component_size(Nums) ->
    Max = lists:max(Nums),
    UF = array:new([{size, Max + 1}, {default, -1}]),
    PrimeMap = maps:new(),
    {PrimeMap1, UF1} = process_numbers(Nums, PrimeMap, UF),
    find_largest_component(UF1, Nums, 0).

process_numbers([], PrimeMap, UF) -> {PrimeMap, UF};
process_numbers([Num | Rest], PrimeMap, UF) ->
    Factors = get_prime_factors(Num),
    {PrimeMap1, UF1} = process_factors(Factors, Num, PrimeMap, UF),
    process_numbers(Rest, PrimeMap1, UF1).

process_factors([], _, PrimeMap, UF) -> {PrimeMap, UF};
process_factors([Factor | Rest], Num, PrimeMap, UF) ->
    case maps:is_key(Factor, PrimeMap) of
        true ->
            OtherNum = maps:get(Factor, PrimeMap),
            UF1 = union(UF, Num, OtherNum),
            process_factors(Rest, Num, PrimeMap, UF1);
        false ->
            PrimeMap1 = maps:put(Factor, Num, PrimeMap),
            process_factors(Rest, Num, PrimeMap1, UF)
    end.

get_prime_factors(N) ->
    get_prime_factors(N, 2, []).

get_prime_factors(1, _, Acc) -> lists:usort(Acc);
get_prime_factors(N, D, Acc) when D * D > N ->
    lists:usort([N | Acc]);
get_prime_factors(N, D, Acc) when N rem D =:= 0 ->
    get_prime_factors(N div D, D, [D | Acc]);
get_prime_factors(N, D, Acc) ->
    get_prime_factors(N, D + 1, Acc).

find(UF, X) ->
    case array:get(X, UF) of
        -1 -> X;
        Parent ->
            Root = find(UF, Parent),
            UF1 = array:set(X, Root, UF),
            Root
    end.

union(UF, X, Y) ->
    RootX = find(UF, X),
    RootY = find(UF, Y),
    if
        RootX =:= RootY -> UF;
        true -> array:set(RootY, RootX, UF)
    end.

find_largest_component(UF, Nums, Max) ->
    CountMap = lists:foldl(fun(Num, Map) ->
        Root = find(UF, Num),
        maps:update_with(Root, fun(V) -> V + 1 end, 1, Map)
    end, maps:new(), Nums),
    case maps:values(CountMap) of
        [] -> Max;
        Counts -> lists:max(Counts)
    end.