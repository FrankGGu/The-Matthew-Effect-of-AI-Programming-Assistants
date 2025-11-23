-module(gcd_sort).
-export([gcd_sort/1]).

gcd_sort(Nums) ->
    Max = lists:max(Nums),
    Sieve = sieve(Max),
    UF = init_uf(Max),
    UF1 = connect_numbers(Nums, Sieve, UF),
    Sorted = lists:sort(Nums),
    check_possible(Nums, Sorted, UF1, 0).

sieve(Max) ->
    Sieve = array:new([{size, Max + 1}, {fixed, true}, {default, 0}]),
    lists:foldl(fun(P, S) ->
        case array:get(P, S) of
            0 ->
                lists:foldl(fun(M, Acc) ->
                    array:set(M, P, Acc)
                end, S, lists:seq(P, Max, P));
            _ ->
                S
        end
    end, Sieve, lists:seq(2, Max)).

init_uf(Max) ->
    array:new([{size, Max + 1}, {fixed, true}, {default, -1}]).

find(UF, X) ->
    Parent = array:get(X, UF),
    if
        Parent < 0 -> X;
        true ->
            Root = find(UF, Parent),
            UF1 = array:set(X, Root, UF),
            Root
    end.

union(UF, X, Y) ->
    RootX = find(UF, X),
    RootY = find(UF, Y),
    if
        RootX =:= RootY -> UF;
        true ->
            RankX = array:get(RootX, UF),
            RankY = array:get(RootY, UF),
            if
                RankX < RankY ->
                    array:set(RootY, RootX, UF);
                RankY < RankX ->
                    array:set(RootX, RootY, UF);
                true ->
                    UF1 = array:set(RootY, RootX, UF),
                    array:set(RootX, RankX - 1, UF1)
            end
    end.

connect_numbers([], _, UF) -> UF;
connect_numbers([Num | Rest], Sieve, UF) ->
    Factors = get_factors(Num, Sieve, []),
    UF1 = connect_factors(Factors, Num, UF),
    connect_numbers(Rest, Sieve, UF1).

get_factors(1, _, Acc) -> Acc;
get_factors(Num, Sieve, Acc) ->
    P = array:get(Num, Sieve),
    if
        P =:= 0 -> [Num | Acc];
        true -> get_factors(Num div P, Sieve, [P | Acc])
    end.

connect_factors([], _, UF) -> UF;
connect_factors([Factor | Rest], Num, UF) ->
    UF1 = union(UF, Num, Factor),
    connect_factors(Rest, Num, UF1).

check_possible([], [], _, _) -> true;
check_possible([Orig | OrigRest], [Sorted | SortedRest], UF, _) ->
    RootOrig = find(UF, Orig),
    RootSorted = find(UF, Sorted),
    if
        RootOrig =:= RootSorted -> check_possible(OrigRest, SortedRest, UF, 0);
        true -> false
    end.