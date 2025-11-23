-module(solution).
-export([gcd_sort/1]).

build_spf_sieve(MaxVal) ->
    SieveArray = array:new([{size, MaxVal + 1}, {fixed, true}, {default, 0}]),
    SieveArray1 = array:set(0, 0, SieveArray), % 0 and 1 are special
    SieveArray2 = array:set(1, 1, SieveArray1), % 1 is not prime

    lists:foldl(
        fun(I, CurrentSieve) ->
            case array:get(I, CurrentSieve) of
                0 -> % I is prime, its spf is itself
                    SieveWithI = array:set(I, I, CurrentSieve),
                    % Mark multiples of I
                    lists:foldl(
                        fun(J, InnerSieve) ->
                            case array:get(J, InnerSieve) of
                                0 -> array:set(J, I, InnerSieve); % Only set if not already marked by a smaller prime
                                _ -> InnerSieve
                            end
                        end,
                        SieveWithI,
                        lists:seq(I*I, MaxVal, I)
                    );
                _ -> CurrentSieve % I is composite, its spf already set
            end
        end,
        SieveArray2,
        lists:seq(2, MaxVal)
    ).

get_prime_factors(N, SieveArray) ->
    get_prime_factors_acc(N, SieveArray, maps:new()).

get_prime_factors_acc(1, _SieveArray, AccMap) ->
    maps:keys(AccMap);
get_prime_factors_acc(N, SieveArray, AccMap) ->
    SPF = array:get(N, SieveArray),
    NewAccMap = maps:put(SPF, true, AccMap),
    get_prime_factors_acc(N div SPF, SieveArray, NewAccMap).

find(Node, ParentTable) ->
    case ets:lookup(ParentTable, Node) of
        [] -> % Node not initialized, this case should not be reached with full initialization
            Node;
        [{Node, Parent}] when Node == Parent ->
            Node;
        [{Node, Parent}] ->
            Root = find(Parent, ParentTable),
            ets:insert(ParentTable, {Node, Root}), % Path compression
            Root
    end.

union(Node1, Node2, ParentTable, RankTable) ->
    Root1 = find(Node1, ParentTable),
    Root2 = find(Node2, ParentTable),

    if Root1 /= Root2 ->
        Rank1 = case ets:lookup(RankTable, Root1) of
                    [] -> 0; % Should not be reached with full initialization
                    [{_, R}] -> R
                end,
        Rank2 = case ets:lookup(RankTable, Root2) of
                    [] -> 0; % Should not be reached with full initialization
                    [{_, R}] -> R
                end,

        if Rank1 < Rank2 ->
            ets:insert(ParentTable, {Root1, Root2});
        Rank1 > Rank2 ->
            ets:insert(ParentTable, {Root2, Root1});
        true -> % Ranks are equal
            ets:insert(ParentTable, {Root2, Root1}),
            ets:insert(RankTable, {Root1, Rank1 + 1})
        end;
    true ->
        ok % Already in the same set
    end.

gcd_sort(Nums) ->
    if Nums == [] ->
        true;
    true ->
        MaxVal = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, Nums),

        Sieve = build_spf_sieve(MaxVal),

        ParentTable = ets:new(parent_table, [set, public, {read_concurrency, true}]),
        RankTable = ets:new(rank_table, [set, public, {read_concurrency, true}]),

        %% Initialize DSU for all numbers up to MaxVal
        lists:foreach(
            fun(I) ->
                ets:insert(ParentTable, {I, I}),
                ets:insert(RankTable, {I, 0})
            end,
            lists:seq(0, MaxVal)
        ),

        %% Connect numbers to their prime factors
        lists:foreach(
            fun(N) ->
                Factors = get_prime_factors(N, Sieve),
                lists:foreach(
                    fun(P) ->
                        union(N, P, ParentTable, RankTable)
                    end,
                    Factors
                )
            end,
            Nums
        ),

        SortedNums = lists:sort(Nums),

        %% Check if each original number and its corresponding sorted number are in the same component
        check_components(Nums, SortedNums, ParentTable)
    end.

check_components([], [], _ParentTable) ->
    true;
check_components([H1|T1], [H2|T2], ParentTable) ->
    Root1 = find(H1, ParentTable),
    Root2 = find(H2, ParentTable),

    if Root1 == Root2 ->
        check_components(T1, T2, ParentTable);
    true ->
        false
    end.