-module(solution).
-export([ways_to_build_rooms/1]).

ways_to_build_rooms(PrevRoom) ->
    N = length(PrevRoom),
    Mod = 1000000007,
    {Fact, InvFact} = precompute_factorials(N, Mod),
    Tree = build_tree(PrevRoom),
    {Ans, _} = dfs(0, Tree, Fact, InvFact, Mod),
    Ans.

build_tree(PrevRoom) ->
    N = length(PrevRoom),
    Tree = lists:foldl(fun(I, Acc) -> maps:put(I, [], Acc) end, #{}, lists:seq(0, N-1)),
    lists:foldl(fun
        (0, Acc) -> Acc;
        (I, Acc) ->
            Parent = lists:nth(I, PrevRoom),
            Children = maps:get(Parent, Acc, []),
            maps:put(Parent, [I | Children], Acc)
    end, Tree, lists:seq(1, N-1)).

precompute_factorials(N, Mod) ->
    Fact = lists:foldl(fun(I, Acc) ->
        case I of
            0 -> [1 | Acc];
            _ -> [(hd(Acc) * I rem Mod) | Acc]
        end
    end, [], lists:seq(0, N)),
    Fact1 = lists:reverse(Fact),
    InvFact = compute_inv_fact(Fact1, Mod),
    {Fact1, InvFact}.

compute_inv_fact(Fact, Mod) ->
    Last = lists:last(Fact),
    InvLast = mod_inverse(Last, Mod),
    lists:foldl(fun(F, {InvAcc, PrevInv}) ->
        InvF = PrevInv * F rem Mod,
        {[InvF | InvAcc], InvF}
    end, {[InvLast], InvLast}, lists:reverse(lists:sublist(Fact, 1, length(Fact)-1))).

mod_inverse(A, Mod) ->
    {G, X, _} = extended_gcd(A, Mod),
    if
        G =:= 1 -> (X rem Mod + Mod) rem Mod;
        true -> 0
    end.

extended_gcd(A, 0) -> {A, 1, 0};
extended_gcd(A, B) ->
    {G, X, Y} = extended_gcd(B, A rem B),
    {G, Y, X - (A div B) * Y}.

dfs(Node, Tree, Fact, InvFact, Mod) ->
    case maps:get(Node, Tree) of
        [] -> {1, 1};
        Children ->
            {ResList, SizeList} = lists:foldl(fun(Child, {ResAcc, SizeAcc}) ->
                {Res, Size} = dfs(Child, Tree, Fact, InvFact, Mod),
                {[Res | ResAcc], [Size | SizeAcc]}
            end, {[], []}, Children),
            TotalSize = lists:sum(SizeList) + 1,
            Ways = lists:foldl(fun(Size, Acc) ->
                Acc * lists:nth(Size+1, InvFact) rem Mod
            end, lists:nth(TotalSize, Fact), SizeList),
            Ways1 = lists:foldl(fun(Res, Acc) ->
                Acc * Res rem Mod
            end, Ways, ResList),
            {Ways1, TotalSize}
    end.