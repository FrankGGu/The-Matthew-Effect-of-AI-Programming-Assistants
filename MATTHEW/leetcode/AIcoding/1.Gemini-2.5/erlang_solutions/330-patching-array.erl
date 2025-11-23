-module(solution).
-export([min_patches/2]).

min_patches(Nums, N) ->
    patch(Nums, N, 0, 0).

patch(_Nums, N, Reach, Patches) when Reach >= N ->
    Patches;
patch(Nums, N, Reach, Patches) ->
    case Nums of
        [] ->
            % No more numbers in Nums, must patch Reach + 1
            patch(Nums, N, Reach + (Reach + 1), Patches + 1);
        [H|T] when H =< Reach + 1 ->
            % Current number H can extend Reach
            patch(T, N, Reach + H, Patches);
        [H|_] when H > Reach + 1 ->
            % Current number H is too large, must patch Reach + 1
            patch(Nums, N, Reach + (Reach + 1), Patches + 1)
    end.