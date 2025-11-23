-module(solution).
-export([count_palindrome_paths/1]).

count_palindrome_paths(Parent :: [integer()], S :: unicode:unicode_binary()) -> integer().
count_palindrome_paths(Parent, S) ->
    N = length(Parent),
    SList = unicode:characters_to_list(S),
    Tree = build_tree(Parent, SList),
    M = maps:new(),
    {Res, _} = dfs(0, 0, Tree, M),
    Res.

build_tree(Parent, S) ->
    N = length(Parent),
    Tree = maps:from_list([{I, {lists:nth(I + 1, S), []}} || I <- lists:seq(0, N - 1)]),
    lists:foldl(fun(I, Acc) ->
                    P = lists:nth(I + 1, Parent),
                    if P /= -1 ->
                           {C, Children} = maps:get(P, Acc),
                           maps:put(P, {C, [I | Children]}, Acc);
                       true -> Acc
                    end
                end, Tree, lists:seq(1, N - 1)).

dfs(Node, Mask, Tree, M) ->
    {C, Children} = maps:get(Node, Tree),
    NewMask = Mask bxor (1 bsl (C - $a)),
    Count = maps:get(NewMask, M, 0),
    Res = Count,
    M1 = maps:put(NewMask, Count + 1, M),
    {Res1, M2} = lists:foldl(fun(Child, {Acc, Map}) ->
                                {R, NewMap} = dfs(Child, NewMask, Tree, Map),
                                {Acc + R, NewMap}
                             end, {Res, M1}, Children),
    Total = Res1,
    lists:foreach(fun(I <- 0..25) ->
                     Key = NewMask bxor (1 bsl I),
                     Total = Total + maps:get(Key, M2, 0)
                  end, 0),
    {Total, M2}.