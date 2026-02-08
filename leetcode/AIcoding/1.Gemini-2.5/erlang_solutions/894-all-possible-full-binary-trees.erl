-module(solution).
-export([allPossibleFBT/1]).

-spec allPossibleFBT(N :: integer()) -> [any()].
allPossibleFBT(N) ->
    Memo = maps:new(),
    {Trees, _FinalMemo} = solve(N, Memo),
    Trees.

solve(N, Memo) when N rem 2 == 0 -> {[], Memo};
solve(1, Memo) -> {[{0, nil, nil}], Memo};
solve(N, Memo) ->
    case maps:find(N, Memo) of
        {ok, Result} -> {Result, Memo};
        error ->
            {TreesList, UpdatedMemo} = generate_trees(N, Memo),
            Trees = lists:flatten(TreesList),
            {Trees, maps:put(N, Trees, UpdatedMemo)}
    end.

generate_trees(N, InitialMemo) ->
    generate_trees_loop(1, N - 2, N, InitialMemo, []).

generate_trees_loop(I, MaxI, N, CurrentMemo, Acc) when I > MaxI ->
    {Acc, CurrentMemo};
generate_trees_loop(I, MaxI, N, CurrentMemo, Acc) ->
    {LeftTrees, Memo1} = solve(I, CurrentMemo),
    {RightTrees, Memo2} = solve(N - 1 - I, Memo1),

    NewTrees = [ {0, L, R} || L <- LeftTrees, R <- RightTrees ],

    generate_trees_loop(I + 2, MaxI, N, Memo2, [NewTrees | Acc]).