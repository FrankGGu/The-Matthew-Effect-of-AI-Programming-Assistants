-module(solution).
-export([can_traverse/1]).

can_traverse(Nums) ->
    case Nums of
        [] -> false;
        [_] -> true;
        _ ->
            N = length(Nums),
            UF = init_uf(N),
            Pairs = get_pairs(Nums),
            connect_pairs(Pairs, UF, Nums),
            check_connected(UF)
    end.

init_uf(N) ->
    lists:duplicate(N, -1).

find(UF, X) ->
    Parent = lists:nth(X + 1, UF),
    if
        Parent < 0 -> X;
        true ->
            Root = find(UF, Parent),
            UF1 = setelement(X + 1, list_to_tuple(UF), Root),
            Root
    end.

union(UF, X, Y) ->
    RootX = find(UF, X),
    RootY = find(UF, Y),
    if
        RootX =:= RootY -> UF;
        true ->
            SizeX = -lists:nth(RootX + 1, UF),
            SizeY = -lists:nth(RootY + 1, UF),
            if
                SizeX > SizeY ->
                    UF1 = setelement(RootY + 1, list_to_tuple(UF), RootX),
                    UF2 = setelement(RootX + 1, list_to_tuple(UF1), -(SizeX + SizeY)),
                    tuple_to_list(UF2);
                true ->
                    UF1 = setelement(RootX + 1, list_to_tuple(UF), RootY),
                    UF2 = setelement(RootY + 1, list_to_tuple(UF1), -(SizeX + SizeY)),
                    tuple_to_list(UF2)
            end
    end.

get_pairs(Nums) ->
    N = length(Nums),
    [{I, J} || I <- lists:seq(0, N - 1), J <- lists:seq(I + 1, N - 1)].

connect_pairs([], UF, _) -> UF;
connect_pairs([{I, J} | Rest], UF, Nums) ->
    NumI = lists:nth(I + 1, Nums),
    NumJ = lists:nth(J + 1, Nums),
    case gcd(NumI, NumJ) > 1 of
        true -> 
            NewUF = union(UF, I, J),
            connect_pairs(Rest, NewUF, Nums);
        false ->
            connect_pairs(Rest, UF, Nums)
    end.

check_connected(UF) ->
    Roots = [find(UF, I) || I <- lists:seq(0, length(UF) - 1)],
    length(lists:usort(Roots)) =:= 1.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).