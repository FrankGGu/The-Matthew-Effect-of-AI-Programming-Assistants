-spec min_patches(Nums :: [integer()], N :: integer()) -> integer().
min_patches(Nums, N) ->
    min_patches(Nums, N, 0, 1, 0).

min_patches(_, N, Patches, Miss, _) when Miss > N ->
    Patches;
min_patches([], N, Patches, Miss, _) ->
    min_patches([], N, Patches + 1, Miss * 2, Miss);
min_patches([Num | Rest], N, Patches, Miss, Sum) when Num =< Miss ->
    min_patches(Rest, N, Patches, Miss + Num, Sum + Num);
min_patches(Nums, N, Patches, Miss, _) ->
    min_patches(Nums, N, Patches + 1, Miss * 2, Miss).