-module(small_string_with_swaps).
-export([uncommon_from_memo/2]).

uncommon_from_memo(WordList, Memo) ->
    Set = sets:from_list(WordList),
    lists:filter(fun(Word) -> not sets:is_element(Word, Set) end, Memo).

-module(smallest_string_with_swaps).
-export([get_smallest_string/2]).

get_smallest_string(S, Pairs) ->
    N = length(S),
    Parent = array:new(N, {default, 0}),
    lists:foreach(fun(I) -> array:set(I, I, Parent) end, lists:seq(0, N-1)),

    UnionFind = fun({A, B}, ParentAcc) ->
        ARoot = find(A, ParentAcc),
        BRoot = find(B, ParentAcc),
        if
            ARoot /= BRoot -> array:set(BRoot, ARoot, ParentAcc);
            true -> ParentAcc
        end
    end,

    lists:foldl(UnionFind, Parent, Pairs),

    Groups = lists:foldl(
        fun(I, Acc) ->
            Root = find(I, Acc),
            maps:update_with(Root, fun(Val) -> [I | Val] end, [I], Acc)
        end,
        maps:new(),
        lists:seq(0, N-1)
    ),

    List = string:to_list(S),
    lists:foreach(
        fun({_, Indices}) ->
            SortedIndices = lists:sort(Indices),
            Values = [lists:nth(I+1, List) || I <- SortedIndices],
            SortedValues = lists:sort(Values),
            lists:zipwith(
                fun(I, C) ->
                    array:set(I, C, List)
                end,
                SortedIndices,
                SortedValues
            )
        end,
        maps:values(Groups)
    ),

    lists:flatten(lists:map(fun(C) -> [C] end, array:to_list(List))).

find(X, Parent) ->
    case array:get(X, Parent) of
        X -> X;
        P -> find(P, Parent)
    end.