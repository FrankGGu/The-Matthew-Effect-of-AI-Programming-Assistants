-module(solution).
-export([count_components/1]).

-spec count_components(Nums :: [integer()]) -> integer().
count_components(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            IndexMap = maps:from_list([{Num, I} || {I, Num} <- lists:zip(lists:seq(0, length(Nums) - 1), Nums)]),
            UF = union_find:new(length(Nums)),
            lists:foldl(
                fun(Num, AccUF) ->
                    lists:foldl(
                        fun(OtherNum, InnerUF) ->
                            case gcd(Num, OtherNum) > 1 of
                                true ->
                                    I = maps:get(Num, IndexMap),
                                    J = maps:get(OtherNum, IndexMap),
                                    union_find:union(InnerUF, I, J);
                                false ->
                                    InnerUF
                            end
                        end,
                        AccUF,
                        Nums
                    )
                end,
                UF,
                Nums
            ),
            union_find:count(UF)
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

-module(union_find).
-export([new/1, find/2, union/3, count/1]).

new(N) ->
    {lists:seq(0, N-1), lists:duplicate(N, 1), N}.

find({Parent, _, _}, X) ->
    case lists:nth(X+1, Parent) of
        X -> X;
        P ->
            Root = find({Parent, [], 0}, P),
            {NewParent, _, _} = set_parent({Parent, [], 0}, X, Root),
            Root
    end.

set_parent({Parent, Size, Count}, X, P) ->
    NewParent = lists:sublist(Parent, X) ++ [P] ++ lists:nthtail(X+1, Parent),
    {NewParent, Size, Count}.

union(UF, X, Y) ->
    RootX = find(UF, X),
    RootY = find(UF, Y),
    case RootX =:= RootY of
        true -> UF;
        false ->
            {Parent, Size, Count} = UF,
            SizeX = lists:nth(RootX+1, Size),
            SizeY = lists:nth(RootY+1, Size),
            case SizeX < SizeY of
                true ->
                    NewParent = lists:sublist(Parent, RootX) ++ [RootY] ++ lists:nthtail(RootX+1, Parent),
                    NewSize = lists:sublist(Size, RootY) ++ [SizeX + SizeY] ++ lists:nthtail(RootY+1, Size),
                    {NewParent, NewSize, Count - 1};
                false ->
                    NewParent = lists:sublist(Parent, RootY) ++ [RootX] ++ lists:nthtail(RootY+1, Parent),
                    NewSize = lists:sublist(Size, RootX) ++ [SizeX + SizeY] ++ lists:nthtail(RootX+1, Size),
                    {NewParent, NewSize, Count - 1}
            end
    end.

count({_, _, Count}) -> Count.