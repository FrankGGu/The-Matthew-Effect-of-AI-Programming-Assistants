-spec min_length_after_removals(Nums :: [integer()]) -> integer().
min_length_after_removals(Nums) ->
    N = length(Nums),
    I = 0,
    J = (N + 1) div 2,
    Count = 0,
    loop(Nums, I, J, N, Count).

loop(Nums, I, J, N, Count) when J < N ->
    if
        lists:nth(I + 1, Nums) < lists:nth(J + 1, Nums) ->
            loop(Nums, I + 1, J + 1, N, Count + 1);
        true ->
            loop(Nums, I, J + 1, N, Count)
    end;
loop(_, _, _, N, Count) ->
    N - 2 * Count.