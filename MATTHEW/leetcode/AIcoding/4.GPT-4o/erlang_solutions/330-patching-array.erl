-spec min_patches(Nums :: [integer()], N :: integer()) -> integer().
min_patches(Nums, N) ->
    min_patches(Nums, N, 1, 0).

min_patches([], N, Sum, Patches) when Sum > N -> Patches;
min_patches([], N, Sum, Patches) ->
    min_patches([Sum | []], N, Sum + Sum, Patches + 1);

min_patches([H | T], N, Sum, Patches) when H > Sum ->
    min_patches([H | T], N, Sum + Sum, Patches + 1);

min_patches([H | T], N, Sum, Patches) when Sum >= N -> Patches;
min_patches([H | T], N, Sum, Patches) -> min_patches(T, N, Sum + H, Patches).
